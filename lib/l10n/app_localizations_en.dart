// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get signUpTitle => 'Sign Up';

  @override
  String get signUpSubTitle => 'Get started with your details';

  @override
  String get signUpTEFFirstName => 'First Name';

  @override
  String get signUpTEFLastName => 'Last Name';

  @override
  String get signUpTEFEmail => 'Email';

  @override
  String get signUpTEFPassword => 'Password';

  @override
  String get signUpTEFPhone => 'Phone';

  @override
  String get signUpTEFCity => 'City';

  @override
  String get signUpFilledButtonText => 'Sign Up';

  @override
  String get signUpAlreadyAccountText => 'Already have an account?';

  @override
  String get signUpTextButtonText => 'Sign In';

  @override
  String get signUpFirstNameValidator => 'Enter your first name';

  @override
  String get signUpLastNameValidator => 'Enter your last name';

  @override
  String get signUpEmailValidator => 'Enter a valid email';

  @override
  String get signUpPasswordValidator => 'Enter a password';

  @override
  String get signUpPasswordValidator6Digit => 'Enter minimum 6 digit password';

  @override
  String get signUpPhoneValidator => 'Enter a phone number';

  @override
  String get signUpCityValidator => 'Enter your city';

  @override
  String get signInTitle => 'Sign In';

  @override
  String get signInSubTitle => 'Login your account with email and password';

  @override
  String get signInTEFEmail => 'Email';

  @override
  String get signInTEFPassword => 'Password';

  @override
  String get signInFilledButtonText => 'Sign In';

  @override
  String get signInNeedAnAccountText => 'Need an Account?';

  @override
  String get signInTextButtonText => 'Sign Up';

  @override
  String get signInEmailValidator => 'Enter a valid email';

  @override
  String get signInPasswordValidator => 'Enter a password';

  @override
  String get signInPasswordValidator6Digit => 'Enter minimum 6 digit password';

  @override
  String get otpVerificationTitle => 'Enter OTP Code';

  @override
  String get otpVerificationSubTitle => 'A 4 digit otp code has been sent';

  @override
  String get otpVerificationFilledButtonText => 'Verify OTP';

  @override
  String get otpVerificationTextButtonText => 'Resend Code';
}
