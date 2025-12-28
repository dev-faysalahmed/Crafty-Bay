import 'package:crafty_bay/app/app_color.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:crafty_bay/features/auth/presentation/widget/app_logo.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                Text('Sign Up', style: textTheme.headlineMedium?.copyWith(
                    fontWeight: .bold)),
                Text(
                  'Get started with your details', style: textTheme.bodyLarge,),
                const SizedBox(height: 16,),
                TextFormField(
                  textInputAction: .next,
                  decoration: InputDecoration(
                      hintText: 'First Name'
                  ),
                  validator: (String? value) {
                    if (value
                        ?.trim()
                        .isEmpty ?? true) {
                      return 'Enter your first name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  textInputAction: .next,
                  decoration: InputDecoration(
                      hintText: 'Last Name'
                  ),
                  validator: (String? value) {
                    if (value
                        ?.trim()
                        .isEmpty ?? true) {
                      return 'Enter your last name';
                    }
                    return null;
                  },
                ),
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
                  textInputAction: .next,
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
                TextFormField(
                  textInputAction: .next,
                  keyboardType: .phone,
                  decoration: InputDecoration(
                      hintText: 'Phone'
                  ),
                  validator: (String? value) {
                    if (value
                        ?.trim()
                        .isEmpty ?? true) {
                      return 'Enter a phone number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  textInputAction: .done,
                  decoration: InputDecoration(
                      hintText: 'City'
                  ),
                  validator: (String? value) {
                    if (value
                        ?.trim()
                        .isEmpty ?? true) {
                      return 'Enter your city';
                    }
                    return null;
                  },
                ),
                FilledButton(
                    onPressed: _onTabSignUpButton, child: Text('Sign Up')),
                const SizedBox(height: 8,),
                RichText(text: TextSpan(style: textTheme.bodyMedium,
                    text: 'Already have an account?',
                    children: [
                      TextSpan(
                          style: TextStyle(
                              color: AppColor.themeColor, fontWeight: .bold),
                          text: ' Sign In',
                          recognizer: TapGestureRecognizer()..onTap = _onTabSignInButton,
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

  }
  void _onTabSignInButton() {
    Navigator.pushNamed(context, SignInScreen.name);
  }
}
