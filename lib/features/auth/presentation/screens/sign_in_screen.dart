import 'package:crafty_bay/app/app_color.dart';
import 'package:crafty_bay/app/extensions/localization_extension.dart';
import 'package:crafty_bay/features/auth/presentation/screens/otp_verification_screen.dart';
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
                Text(localText.signInTitle, style: textTheme.headlineMedium?.copyWith(
                    fontWeight: .bold)),
                Text(
                  localText.signInSubTitle, style: textTheme.bodyLarge, textAlign: .center,),
                const SizedBox(height: 16,),
                TextFormField(
                  textInputAction: .next,
                  keyboardType: .emailAddress,
                  decoration: InputDecoration(
                      hintText: localText.signInTEFEmail
                  ),
                  validator: (String? value) {
                    String inputEmail = value ?? '';
                    if (EmailValidator.validate(inputEmail) == false) {
                      return localText.signInEmailValidator;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  textInputAction: .done,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                      hintText: localText.signInTEFPassword
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return localText.signInPasswordValidator;
                    } else if (value!.length < 6) {
                      return localText.signInPasswordValidator6Digit;
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: .end,
                  children: [
                    TextButton(onPressed: _onTabForgotPasswordButton, child: Text('Forgot Password?'))
                  ],
                ),
                FilledButton(
                    onPressed: _onTabSignInButton, child: Text(localText.signInFilledButtonText)),
                const SizedBox(height: 8,),
                RichText(text: TextSpan(style: textTheme.bodyMedium,
                    text: localText.signInNeedAnAccountText,
                    children: [
                      TextSpan(
                          style: TextStyle(
                              color: AppColor.themeColor, fontWeight: .bold),
                          text: ' ${localText.signInTextButtonText}',
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

  void _onTabForgotPasswordButton(){
    Navigator.pushNamed(context, OtpVerificationScreen.name);
  }
  void _onTabSignUpButton() {
    Navigator.pop(context);
  }
  void _onTabSignInButton() {

  }
}
