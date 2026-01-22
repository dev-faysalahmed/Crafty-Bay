import 'package:crafty_bay/app/app_color.dart';
import 'package:crafty_bay/app/assets_paths.dart';
import 'package:crafty_bay/app/constants.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:crafty_bay/features/category/data/models/category_model.dart';
import 'package:crafty_bay/features/category/presentation/providers/category_list_provider.dart';
import 'package:crafty_bay/features/common/presentation/widget/center_circular_progress.dart';
import 'package:crafty_bay/features/home/presantation/providers/home_products_provider.dart';
import 'package:crafty_bay/features/product/presentation/providers/product_list_by_slug_provider.dart';
import 'package:crafty_bay/features/home/presantation/providers/home_slider_provider.dart';
import 'package:crafty_bay/features/product/presentation/screens/product_list_by_slug_screen.dart';
import 'package:crafty_bay/features/home/presantation/widget/home_carousel_slider.dart';
import 'package:crafty_bay/features/product/data/models/product_model.dart';
import 'package:crafty_bay/features/product/presentation/screens/product_list_by_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../auth/presentation/providers/auth_controller.dart';
import '../../../auth/presentation/screens/sign_up_screen.dart';
import '../../../common/presentation/providers/add_wish_list_provider.dart';
import '../../../common/presentation/providers/main_nav_container_provider.dart';
import '../../../common/presentation/widget/category_card.dart';
import '../../../common/presentation/widget/product_card.dart';
import '../../../common/presentation/widget/snack_bar_message.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  
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
                Map<String, dynamic> map = {"title":"Popular", "slug":"67c35af85e8a445235de197b"};
                Navigator.pushNamed(context, ProductListBySlugScreen.name, arguments: map);
              }),
              _buildPopularProductList(),
              SectionHeader(title: 'Special', onTapSeeAll: () {
                Map<String, dynamic> map = {"title":"Special", "slug":"67c35b395e8a445235de197e"};
                Navigator.pushNamed(context, ProductListBySlugScreen.name, arguments: map);
              }),
              _buildSpecialProductList(),
              SectionHeader(title: 'New', onTapSeeAll: () {
                Map<String, dynamic> map = {"title":"New Arrival", "slug":"67c7bec4623a876bc4766fea"};
                Navigator.pushNamed(context, ProductListBySlugScreen.name, arguments: map);

              }),
              _buildNewProductList(),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularProductList() {
    return SizedBox(
              height: 170,
              child: Consumer<HomeProductsProvider>(
                builder: (context, provider, _) {
                  final List<ProductModel> productList = provider.popularProductList;
                  if(provider.getPopularListInProgress){
                    return CenterCircularProgress();
                  }
                  return ListView.builder(
                    scrollDirection: .horizontal,
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      final product = productList[index];
                    return ProductCard(product: product, onTapFavourite: () { _onTapAddWishList(productId: product.id); }, fromWishList: false,);
                  },);
                }
              ),
            );
  }

  Widget _buildSpecialProductList() {
    return SizedBox(
      height: 170,
      child: Consumer<HomeProductsProvider>(
          builder: (context, provider, _) {
            final List<ProductModel> productList = provider.specialProductList;
            if(provider.getSpecialListInProgress){
              return CenterCircularProgress();
            }
            return ListView.builder(
              scrollDirection: .horizontal,
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                return ProductCard(product: product, onTapFavourite: () { _onTapAddWishList(productId: product.id); }, fromWishList: false,);
              },);
          }
      ),
    );
  }

  Widget _buildNewProductList() {
    return SizedBox(
      height: 170,
      child: Consumer<HomeProductsProvider>(
          builder: (context, provider, _) {
            final List<ProductModel> productList = provider.newProductList;
            if(provider.getNewListInProgress){
              return CenterCircularProgress();
            }
            return ListView.builder(
              scrollDirection: .horizontal,
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                return ProductCard(product: product, onTapFavourite: () { _onTapAddWishList(productId: product.id); }, fromWishList: false,);
              },);
          }
      ),
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

  Future<void> _onTapAddWishList({required String productId}) async {
    if(await AuthController.isAlreadyLoggedIn()){
      final bool isSuccess = await context.read<AddWishListProvider>().addWishList(productId: productId);
      if(isSuccess){
        showSnackBarMessage(context, 'Added to wish list!');
      }else{
        showSnackBarMessage(context, context.read<AddWishListProvider>().errorMessage!);
      }
    }else{
      Navigator.pushNamed(context, SignUpScreen.name);
    }
  }
  
  
}



