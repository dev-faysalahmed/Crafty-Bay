import 'package:crafty_bay/app/app_color.dart';
import 'package:crafty_bay/app/extensions/localization_extension.dart';
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
    var localText = context.localizations;

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
                Text(localText.signUpTitle, style: textTheme.headlineMedium?.copyWith(
                    fontWeight: .bold)),
                Text(
                  localText.signUpSubTitle, style: textTheme.bodyLarge,),
                const SizedBox(height: 16,),
                TextFormField(
                  textInputAction: .next,
                  decoration: InputDecoration(
                      hintText: localText.signUpTEFFirstName
                  ),
                  validator: (String? value) {
                    if (value
                        ?.trim()
                        .isEmpty ?? true) {
                      return localText.signUpFirstNameValidator;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  textInputAction: .next,
                  decoration: InputDecoration(
                      hintText: localText.signUpTEFLastName
                  ),
                  validator: (String? value) {
                    if (value
                        ?.trim()
                        .isEmpty ?? true) {
                      return localText.signUpLastNameValidator;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  textInputAction: .next,
                  keyboardType: .emailAddress,
                  decoration: InputDecoration(
                      hintText: localText.signUpTEFEmail
                  ),
                  validator: (String? value) {
                    String inputEmail = value ?? '';
                    if (EmailValidator.validate(inputEmail) == false) {
                      return localText.signUpEmailValidator;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  textInputAction: .next,
                  decoration: InputDecoration(
                      hintText: localText.signUpTEFPassword
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return localText.signUpPasswordValidator;
                    } else if (value!.length < 6) {
                      return localText.signUpPasswordValidator6Digit;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  textInputAction: .next,
                  keyboardType: .phone,
                  decoration: InputDecoration(
                      hintText: localText.signUpTEFPhone
                  ),
                  validator: (String? value) {
                    if (value
                        ?.trim()
                        .isEmpty ?? true) {
                      return localText.signUpPhoneValidator;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  textInputAction: .done,
                  decoration: InputDecoration(
                      hintText: localText.signUpTEFCity
                  ),
                  validator: (String? value) {
                    if (value
                        ?.trim()
                        .isEmpty ?? true) {
                      return localText.signUpCityValidator;
                    }
                    return null;
                  },
                ),
                FilledButton(
                    onPressed: _onTabSignUpButton, child: Text(localText.signUpFilledButtonText)),
                const SizedBox(height: 8,),
                RichText(text: TextSpan(style: textTheme.bodyMedium,
                    text: localText.signUpAlreadyAccountText,
                    children: [
                      TextSpan(
                          style: TextStyle(
                              color: AppColor.themeColor, fontWeight: .bold),
                          text: ' ${localText.signUpTextButtonText}',
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
