import 'package:crafty_bay/app/extensions/localization_extension.dart';
import 'package:crafty_bay/common/presantation/widget/language_selector.dart';
import 'package:crafty_bay/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../common/presantation/widget/toggle_theme_mode.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(context.localizations.hello),
          Text(context.localizations.name),
          Text(context.localizations.roll),
          LanguageSelector(),
          ToggleThemeMode(),
        ],
      ),),
    );
  }
}
