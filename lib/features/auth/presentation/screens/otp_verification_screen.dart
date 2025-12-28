import 'package:crafty_bay/app/app_color.dart';
import 'package:crafty_bay/app/extensions/localization_extension.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:crafty_bay/features/auth/presentation/widget/app_logo.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  static const String name = '/otp-verification';

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
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
                const SizedBox(height: 8),
                Text(
                  localText.otpVerificationTitle,
                  style: textTheme.headlineMedium?.copyWith(fontWeight: .bold),
                ),
                Text(
                  localText.otpVerificationSubTitle,
                  style: textTheme.bodyLarge,
                  textAlign: .center,
                ),
                const SizedBox(height: 16),
                PinCodeTextField(
                  appContext: context,
                  length: 4,
                  keyboardType: .number,
                  animationType: .fade,
                  enableActiveFill: true,
                  autoFocus: true,
                  pinTheme: PinTheme(
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.transparent,
                    inactiveFillColor: Colors.transparent,
                    selectedFillColor: AppColor.themeColor,
                    inactiveColor: Colors.black,
                    selectedColor: Colors.black,
                    shape: PinCodeFieldShape.box,
                  ),
                ),

                FilledButton(onPressed: _onTabNextButton, child: Text(localText.otpVerificationFilledButtonText)),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: _onTabResendCodeButton,
                  child: Text(localText.otpVerificationTextButtonText),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTabNextButton() {}

  void _onTabResendCodeButton() {}
}
