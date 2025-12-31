import 'dart:async';

import 'package:crafty_bay/app/app_color.dart';
import 'package:crafty_bay/app/extensions/localization_extension.dart';
import 'package:crafty_bay/features/auth/data/models/verify_otp_params.dart';
import 'package:crafty_bay/features/auth/presentation/providers/verify_otp_provider.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:crafty_bay/features/auth/presentation/widget/app_logo.dart';
import 'package:crafty_bay/features/common/presentation/widget/center_circular_progress.dart';
import 'package:crafty_bay/features/common/presentation/widget/snack_bar_message.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key, required this.email});

  static const String name = '/otp-verification';
  final String email;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {

  final VerifyOtpProvider _verifyOtpProvider = VerifyOtpProvider();

  final TextEditingController _otpTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int _secondsRemaining = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    var localText = context.localizations;

    return ChangeNotifierProvider(
      create: (_) => _verifyOtpProvider,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 8,
                  children: [
                    AppLogo(width: 90),
                    const SizedBox(height: 8),
                    Text(
                      localText.otpVerificationTitle,
                      style: textTheme.headlineMedium?.copyWith(
                          fontWeight: .bold),
                    ),
                    Text(
                      localText.otpVerificationSubTitle,
                      style: textTheme.bodyLarge,
                      textAlign: .center,
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: PinCodeTextField(
                        controller: _otpTEController,
                        appContext: context,
                        length: 4,
                        keyboardType: .number,
                        animationType: .fade,
                        enableActiveFill: true,
                        autoFocus: true,
                        pinTheme: PinTheme(
                          fieldHeight: 50,
                          fieldWidth: 50,
                          activeFillColor: Colors.transparent,
                          inactiveFillColor: Colors.transparent,
                          selectedFillColor: AppColor.themeColor,
                          inactiveColor: Colors.black,
                          selectedColor: Colors.black,
                          shape: PinCodeFieldShape.box,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),
                    Consumer<VerifyOtpProvider>(
                        builder: (context, _, _) {
                          return Visibility(
                              visible: _verifyOtpProvider.isVerifyOtpInProgress == false,
                              replacement: CenterCircularProgress(),
                              child: FilledButton(
                              onPressed: _onTabNextButton,
                              child: Text(
                                  localText.otpVerificationFilledButtonText)));
                        }
                    ),
                    RichText(text: TextSpan(style: textTheme.bodyMedium,
                        text: 'This code will expire on',
                        children: [
                          TextSpan(
                            style: TextStyle(
                                color: AppColor.themeColor, fontWeight: .bold),
                            text: ' ${_secondsRemaining}s',
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onTabSignInButton,
                          ),
                        ])),
                    TextButton(
                      onPressed: _onTabResendCodeButton,
                      child: Text(localText.otpVerificationTextButtonText,
                        style: TextStyle(color: (_secondsRemaining > 0) ? Colors
                            .grey : AppColor.themeColor, fontWeight: .bold),),
                    ),
                    RichText(text: TextSpan(style: textTheme.bodyMedium,
                        text: localText.signUpAlreadyAccountText,
                        children: [
                          TextSpan(
                            style: TextStyle(
                                color: AppColor.themeColor, fontWeight: .bold),
                            text: ' ${localText.signUpTextButtonText}',
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onTabSignInButton,
                          ),
                        ]))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsRemaining = 60;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }


  void _onTabSignInButton() {
    Navigator.pushReplacementNamed(context, SignInScreen.name);
  }

  void _onTabNextButton() {
    if (_formKey.currentState!.validate()) {
      _verifyOtp();
    }
  }

  Future<void> _verifyOtp() async {

    final otp = _otpTEController.text;
    VerifyOtpParams params = VerifyOtpParams(email: widget.email, otp: otp);

    bool isSuccess = await _verifyOtpProvider.verifyOtp(params);
    
    if(isSuccess){
      Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (predicate)=>false);
    }else{
      showSnackBarMessage(context, _verifyOtpProvider.errorMassage!);
    }
  }




  void _onTabResendCodeButton() {}

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
