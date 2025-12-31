import 'package:crafty_bay/app/app_color.dart';
import 'package:crafty_bay/app/extensions/localization_extension.dart';
import 'package:crafty_bay/features/auth/data/models/sign_in_params.dart';
import 'package:crafty_bay/features/auth/presentation/providers/sign_in_provider.dart';
import 'package:crafty_bay/features/auth/presentation/screens/otp_verification_screen.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:crafty_bay/features/auth/presentation/widget/app_logo.dart';
import 'package:crafty_bay/features/common/presentation/screen/main_nav_holder_screen.dart';
import 'package:crafty_bay/features/common/presentation/widget/center_circular_progress.dart';
import 'package:crafty_bay/features/common/presentation/widget/language_selector.dart';
import 'package:crafty_bay/features/common/presentation/widget/snack_bar_message.dart';
import 'package:crafty_bay/features/common/presentation/widget/toggle_theme_mode.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final SignInProvider _signInProvider = SignInProvider();

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    var localText = context.localizations;

    return ChangeNotifierProvider(
      create: (_) => _signInProvider,
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
                    const SizedBox(height: 8,),
                    Text(localText.signInTitle, style: textTheme.headlineMedium?.copyWith(
                        fontWeight: .bold)),
                    Text(
                      localText.signInSubTitle, style: textTheme.bodyLarge, textAlign: .center,),
                    const SizedBox(height: 16,),
                    TextFormField(
                      controller: _emailTEController,
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
                      controller: _passwordTEController,
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
                    Consumer<SignInProvider>(
                      builder: (context, _, _) {
                        return Visibility(
                          visible: _signInProvider.isSignInInProgress == false,
                          replacement: CenterCircularProgress(),
                          child: FilledButton(
                              onPressed: _onTabSignInButton, child: Text(localText.signInFilledButtonText)),
                        );
                      }
                    ),
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
                        ])),

                    SizedBox(height: 50,),

                  ],
                ),
              ),
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
    Navigator.pushNamed(context, SignUpScreen.name);
  }
  void _onTabSignInButton() {
    if(_formKey.currentState!.validate()){
      _signIn();
    }
  }

  Future<void> _signIn()async{
    SignInParams params = SignInParams(email: _emailTEController.text.trim(), password: _passwordTEController.text);
    final bool isSuccess = await _signInProvider.signIn(params);

    if(isSuccess){
      Navigator.pushNamedAndRemoveUntil(context, MainNavHolderScreen.name, (predicate)=>false);
    }else{
      showSnackBarMessage(context, _signInProvider.errorMassage!);
    }
  }
}
