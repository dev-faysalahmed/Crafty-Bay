import 'package:crafty_bay/app/app_color.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:crafty_bay/features/auth/presentation/widget/app_logo.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              spacing: 8,
              children: [
                AppLogo(width: 90),
                const SizedBox(height: 8,),
                Text('Sign In', style: textTheme.headlineMedium?.copyWith(
                    fontWeight: .bold)),
                Text(
                  'Login your account with email and password', style: textTheme.bodyLarge, textAlign: .center,),
                const SizedBox(height: 16,),
                TextFormField(
                  textInputAction: .next,
                  keyboardType: .emailAddress,
                  decoration: InputDecoration(
                      hintText: 'Email'
                  ),
                  validator: (String? value) {
                    String inputEmail = value ?? '';
                    if (EmailValidator.validate(inputEmail) == false) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  textInputAction: .done,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                      hintText: 'Password'
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter a password';
                    } else if (value!.length < 6) {
                      return 'Enter minimum 6 digit password';
                    }
                    return null;
                  },
                ),
                FilledButton(
                    onPressed: _onTabSignInButton, child: Text('Sign In')),
                const SizedBox(height: 8,),
                RichText(text: TextSpan(style: textTheme.bodyMedium,
                    text: 'Need an account?',
                    children: [
                      TextSpan(
                          style: TextStyle(
                              color: AppColor.themeColor, fontWeight: .bold),
                          text: ' Sign Up',
                          recognizer: TapGestureRecognizer()..onTap = _onTabSignUpButton,
                      ),
                    ]))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTabSignUpButton() {
    Navigator.pop(context);
  }
  void _onTabSignInButton() {

  }
}
