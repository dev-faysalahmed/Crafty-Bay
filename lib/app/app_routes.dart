import 'package:crafty_bay/features/auth/presentation/screens/otp_verification_screen.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:crafty_bay/features/auth/presentation/screens/splash_screen.dart';
import 'package:crafty_bay/features/category/data/models/category_model.dart';
import 'package:crafty_bay/features/product/presentation/screens/product_list_by_slug_screen.dart';
import 'package:crafty_bay/features/product/presentation/screens/product_details_screen.dart';
import 'package:crafty_bay/features/product/presentation/screens/product_list_by_category_screen.dart';
import 'package:flutter/material.dart';

import '../features/common/presentation/screen/main_nav_holder_screen.dart';

class AppRoutes {
  static Route<dynamic> routes(RouteSettings settings){
    Widget widget = SizedBox();
    if(settings.name == SplashScreen.name){
      widget = SplashScreen();
    }else if(settings.name == SignUpScreen.name){
      widget = SignUpScreen();
    }else if(settings.name == SignInScreen.name){
      widget = SignInScreen();
    }else if(settings.name == OtpVerificationScreen.name){
      final email = settings.arguments as String;
      widget = OtpVerificationScreen(email: email,);
    }else if(settings.name == MainNavHolderScreen.name){
      widget = MainNavHolderScreen();
    }else if(settings.name == ProductListByCategoryScreen.name){
      final CategoryModel categoryModel = settings.arguments as CategoryModel;
      widget = ProductListByCategoryScreen(categoryModel: categoryModel,);
    }else if(settings.name == ProductDetailsScreen.name){
      final Map<String, dynamic> map = settings.arguments as Map<String, dynamic>;
      final String productId = map['productId'];
      final bool fromWishList = map['fromWishList'];
      final String? wishListId = map['wishListId'];
      widget = ProductDetailsScreen(productId: productId, fromWishList: fromWishList, wishListId: wishListId ?? '',);
    }else if(settings.name == ProductListBySlugScreen.name){
      final Map<String, dynamic> map = settings.arguments as Map<String, dynamic>;
      final String title = map['title'];
      final String slug = map['slug'];
      widget = ProductListBySlugScreen(slug: slug, title: title,);
    }

    return MaterialPageRoute(builder: (context) => widget);
  }
}