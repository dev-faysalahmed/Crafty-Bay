import 'package:crafty_bay/app/app_color.dart';
import 'package:crafty_bay/app/assets_paths.dart';
import 'package:crafty_bay/app/constants.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:crafty_bay/features/category/presentation/providers/category_list_provider.dart';
import 'package:crafty_bay/features/common/presentation/widget/center_circular_progress.dart';
import 'package:crafty_bay/features/home/presantation/providers/home_slider_provider.dart';
import 'package:crafty_bay/features/home/presantation/widget/home_carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../common/presentation/providers/main_nav_container_provider.dart';
import '../../../common/presentation/widget/category_card.dart';
import '../../../common/presentation/widget/product_card.dart';
import '../widget/circle_icon_button.dart';
import '../widget/product_search_field.dart';
import '../widget/section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            spacing: 8,
            children: [
              ProductSearchField(),
              Consumer<HomeSliderProvider>(
                builder: (context, homeSliderProvider, _) {
                  if(homeSliderProvider.getHomeSliderInProgress){
                    return SizedBox(
                        height: 200,
                        child: CenterCircularProgress());
                  }
                  return HomeCarouselSlider(homeSliderList: homeSliderProvider.homeSliderList,);
                }
              ),
              SectionHeader(title: 'All Categories', onTapSeeAll: () {
                context.read<MainNavContainerProvider>().changeToCategories();
              }),
              _buildCategoriesList(),
              SectionHeader(title: 'Popular', onTapSeeAll: () {

              }),
              _buildPopularProductList(),
              SectionHeader(title: 'Special', onTapSeeAll: () {

              }),
              _buildPopularProductList(),
              SectionHeader(title: 'New', onTapSeeAll: () {}),
              _buildPopularProductList(),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularProductList() {
    return SizedBox(
              height: 170,
              child: ListView.builder(
                scrollDirection: .horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                //return ProductCard();
              },),
            );
  }


  Widget _buildCategoriesList() {
    return SizedBox(
              height: 85,
              child: Consumer<CategoryListProvider>(
                builder: (context, categoryListProvider, _) {
                  if(categoryListProvider.initialLoading){
                    return CenterCircularProgress();
                  }


                  return ListView.separated(
                    scrollDirection: .horizontal,
                    itemCount: categoryListProvider.categoryList.length > 10 ? 10 : categoryListProvider.categoryList.length,
                    itemBuilder: (context, index) {
                    return CategoryCard(categoryModel: categoryListProvider.categoryList[index],);
                  }, separatorBuilder: (BuildContext context, int index) { return SizedBox(width: 8,); },);
                }
              ),
            );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Row(
        spacing: 4,
        children: [
          SvgPicture.asset(AssetsPaths.vanLogoSvg),
          Spacer(),
          CircleIconButton(icon: Icons.person, onTap: () {
            Navigator.pushNamed(context, SignInScreen.name);
          }),
          CircleIconButton(icon: Icons.call, onTap: () {}),
          CircleIconButton(icon: Icons.notifications_active, onTap: () {}),
        ],
      ),
    );
  }
}



