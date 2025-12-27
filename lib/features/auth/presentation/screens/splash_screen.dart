import 'package:crafty_bay/app/assets_paths.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widget/app_logo.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen()async{
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushNamedAndRemoveUntil(context, SignUpScreen.name, (predicate)=>false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          AppLogo(),
          Spacer(),
          CircularProgressIndicator(),
          SizedBox(height: 16,),
        ],
      ),),
    );
  }
}

