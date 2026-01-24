import 'package:crafty_bay/app/app_color.dart';
import 'package:crafty_bay/features/auth/presentation/providers/auth_controller.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:crafty_bay/features/cart/presentation/screens/cart_list_screen.dart';
import 'package:crafty_bay/features/category/presentation/screens/category_list_screen.dart';
import 'package:crafty_bay/features/home/presantation/providers/home_products_provider.dart';
import 'package:crafty_bay/features/product/presentation/providers/product_list_by_slug_provider.dart';
import 'package:crafty_bay/features/home/presantation/providers/home_slider_provider.dart';
import 'package:crafty_bay/features/home/presantation/screens/home_screen.dart';
import 'package:crafty_bay/features/wish_list/presentation/providers/wish_list_provider.dart';
import 'package:crafty_bay/features/wish_list/presentation/screens/wish_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../category/presentation/providers/category_list_provider.dart';
import '../providers/main_nav_container_provider.dart';

class MainNavHolderScreen extends StatefulWidget {
  const MainNavHolderScreen({super.key});

  static const String name = '/main-bottom-nav-holder';

  @override
  State<MainNavHolderScreen> createState() => _MainNavHolderScreenState();
}

class _MainNavHolderScreenState extends State<MainNavHolderScreen> {

  final List<Widget> _screens = [
    HomeScreen(),
    CategoryListScreen(),
    CartListScreen(),
    WishListScreen()
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CategoryListProvider>().fetchCategoryList();
      context.read<HomeSliderProvider>().getHomeSlider();
      context.read<HomeProductsProvider>().getPopularProductList();
      context.read<HomeProductsProvider>().getSpecialProductList();
      context.read<HomeProductsProvider>().getNewProductList();
    },);

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainNavContainerProvider>(
      builder: (context, mainNavContainerProvide, _) {
        return Scaffold(
          body: _screens[mainNavContainerProvide.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            selectedItemColor: AppColor.themeColor,
            currentIndex: mainNavContainerProvide.selectedIndex,
            onTap: (int index) async {
              if(index == 2 || index ==3){
                if(await AuthController.isAlreadyLoggedIn() == false){
                  Navigator.pushNamed(context, SignUpScreen.name);
                  return;
                }
              }
              mainNavContainerProvide.changeItem(index);
            },
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.card_giftcard_outlined),
                label: 'Wish',
              ),
            ],
          ),
        );
      }
    );
  }
}
