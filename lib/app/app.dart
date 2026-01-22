import 'package:crafty_bay/app/app_routes.dart';
import 'package:crafty_bay/app/app_theme.dart';
import 'package:crafty_bay/app/providers/language_provider.dart';
import 'package:crafty_bay/app/providers/theme_provider.dart';
import 'package:crafty_bay/features/auth/presentation/screens/splash_screen.dart';
import 'package:crafty_bay/features/category/presentation/providers/category_list_provider.dart';
import 'package:crafty_bay/features/common/presentation/providers/add_wish_list_provider.dart';
import 'package:crafty_bay/features/home/presantation/providers/product_list_by_slug_provider.dart';
import 'package:crafty_bay/features/home/presantation/providers/home_slider_provider.dart';
import 'package:crafty_bay/features/wish_list/presentation/providers/wish_list_provider.dart';
import 'package:crafty_bay/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import '../features/common/presentation/providers/main_nav_container_provider.dart';

class CraftyBayApp extends StatefulWidget {
  const CraftyBayApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<CraftyBayApp> createState() => _CraftyBayAppState();
}

class _CraftyBayAppState extends State<CraftyBayApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()..loadInitialLanguage(),),
        ChangeNotifierProvider(create: (context) => ThemeProvider()..loadInitialThemeMode(),),
        ChangeNotifierProvider(create: (context) => MainNavContainerProvider()),
        ChangeNotifierProvider(create: (context) => CategoryListProvider()),
        ChangeNotifierProvider(create: (context) => HomeSliderProvider()),
        ChangeNotifierProvider(create: (context) => AddWishListProvider()),
        ChangeNotifierProvider(create: (context) => WishListProvider()),

      ],
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, _) {
          return Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return MaterialApp(
                // router
                // theme
                navigatorKey: CraftyBayApp.navigatorKey,
                initialRoute: SplashScreen.name,
                onGenerateRoute: AppRoutes.routes,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.dartTheme,
                themeMode: themeProvider.currentThemeMode,
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: [
                  Locale('en'),
                  Locale('bn'),
                  Locale('de'),
                ],
                locale: languageProvider.currentLocal,
              );
            }
          );
        }
      ),
    );
  }
}
