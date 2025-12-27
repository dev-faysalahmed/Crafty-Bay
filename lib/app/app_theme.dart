import 'package:crafty_bay/app/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {

  static ThemeData get lightTheme{
    return ThemeData(
      brightness: Brightness.light,
      colorSchemeSeed: AppColor.themeColor,
      scaffoldBackgroundColor: Colors.white,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColor.themeColor
      )
    );
  }


  static ThemeData get dartTheme{
    return ThemeData(
        brightness: Brightness.dark,
      colorSchemeSeed: AppColor.themeColor,
        progressIndicatorTheme: ProgressIndicatorThemeData(
            color: AppColor.themeColor
        )
    );
  }



}