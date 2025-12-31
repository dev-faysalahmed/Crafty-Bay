import 'package:crafty_bay/app/app_color.dart';
import 'package:crafty_bay/app/extensions/localization_extension.dart';
import 'package:crafty_bay/features/auth/data/models/sign_up_params.dart';
import 'package:crafty_bay/features/auth/presentation/providers/sign_up_provider.dart';
import 'package:crafty_bay/features/auth/presentation/screens/otp_verification_screen.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:crafty_bay/features/auth/presentation/widget/app_logo.dart';
import 'package:crafty_bay/features/common/presentation/widget/snack_bar_message.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/presentation/widget/center_circular_progress.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpProvider _signUpProvider = SignUpProvider();

  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    var localText = context.localizations;

    return ChangeNotifierProvider(
      create: (_) => _signUpProvider,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                autovalidateMode: .onUserInteraction,
                child: Column(
                  spacing: 8,
                  children: [
                    AppLogo(width: 90),
                    const SizedBox(height: 8),
                    Text(
                      localText.signUpTitle,
                      style: textTheme.headlineMedium?.copyWith(
                        fontWeight: .bold,
                      ),
                    ),
                    Text(localText.signUpSubTitle, style: textTheme.bodyLarge),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _firstNameTEController,
                      textInputAction: .next,
                      decoration: InputDecoration(
                        hintText: localText.signUpTEFFirstName,
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return localText.signUpFirstNameValidator;
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _lastNameTEController,
                      textInputAction: .next,
                      decoration: InputDecoration(
                        hintText: localText.signUpTEFLastName,
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return localText.signUpLastNameValidator;
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _emailTEController,
                      textInputAction: .next,
                      keyboardType: .emailAddress,
                      decoration: InputDecoration(
                        hintText: localText.signUpTEFEmail,
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
                      controller: _passwordTEController,
                      obscureText: true,
                      obscuringCharacter: '*',
                      textInputAction: .next,
                      decoration: InputDecoration(
                        hintText: localText.signUpTEFPassword,
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
                      controller: _phoneTEController,
                      textInputAction: .next,
                      keyboardType: .phone,
                      decoration: InputDecoration(
                        hintText: localText.signUpTEFPhone,
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return localText.signUpPhoneValidator;
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _cityTEController,
                      textInputAction: .done,
                      decoration: InputDecoration(
                        hintText: localText.signUpTEFCity,
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return localText.signUpCityValidator;
                        }
                        return null;
                      },
                    ),
                    Consumer<SignUpProvider>(
                      builder: (context, signUpProvider, _) {
                        return Visibility(
                          visible: signUpProvider.isSignUpInProgress == false,
                          replacement: CenterCircularProgress(),
                          child: FilledButton(
                            onPressed: _onTabSignUpButton,
                            child: Text(localText.signUpFilledButtonText),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        style: textTheme.bodyMedium,
                        text: localText.signUpAlreadyAccountText,
                        children: [
                          TextSpan(
                            style: TextStyle(
                              color: AppColor.themeColor,
                              fontWeight: .bold,
                            ),
                            text: ' ${localText.signUpTextButtonText}',
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onTabSignInButton,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTabSignUpButton() {
    if (_formKey.currentState!.validate()) {
      _signUp();
    }
  }

  Future<void> _signUp() async {
    final bool isSuccess = await _signUpProvider.signUp(
      SignUpParams(
        firstName: _firstNameTEController.text.trim(),
        lastName: _lastNameTEController.text.trim(),
        email: _emailTEController.text.trim(),
        password: _passwordTEController.text,
        phone: _phoneTEController.text.trim(),
        city: _cityTEController.text.trim(),
      ),
    );

    if(isSuccess){
      Navigator.pushNamed(context, OtpVerificationScreen.name, arguments: _emailTEController.text.trim());
    }else{
      showSnackBarMessage(context, _signUpProvider.errorMassage!);
    }
  }

  void _onTabSignInButton() {
    Navigator.pushNamed(context, SignInScreen.name);
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _phoneTEController.dispose();
    _cityTEController.dispose();
    super.dispose();
  }
}

