// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get signUpTitle => 'সাইন আপ';

  @override
  String get signUpSubTitle => 'আপনার তথ্য দিয়ে শুরু করুন';

  @override
  String get signUpTEFFirstName => 'নামের প্রথম অংশ';

  @override
  String get signUpTEFLastName => 'নামের শেষ অংশ';

  @override
  String get signUpTEFEmail => 'ইমেইল';

  @override
  String get signUpTEFPassword => 'পাসওয়ার্ড';

  @override
  String get signUpTEFPhone => 'ফোন নম্বর';

  @override
  String get signUpTEFCity => 'শহর';

  @override
  String get signUpFilledButtonText => 'সাইন আপ';

  @override
  String get signUpAlreadyAccountText => 'আগে থেকেই অ্যাকাউন্ট আছে?';

  @override
  String get signUpTextButtonText => 'সাইন ইন';

  @override
  String get signUpFirstNameValidator => 'আপনার নামের প্রথম অংশ লিখুন';

  @override
  String get signUpLastNameValidator => 'আপনার নামের শেষ অংশ লিখুন';

  @override
  String get signUpEmailValidator => 'একটি সঠিক ইমেইল লিখুন';

  @override
  String get signUpPasswordValidator => 'একটি পাসওয়ার্ড লিখুন';

  @override
  String get signUpPasswordValidator6Digit => 'ন্যূনতম ৬ অক্ষরের পাসওয়ার্ড লিখুন';

  @override
  String get signUpPhoneValidator => 'একটি ফোন নম্বর লিখুন';

  @override
  String get signUpCityValidator => 'আপনার শহরের নাম লিখুন';

  @override
  String get signInTitle => 'সাইন ইন';

  @override
  String get signInSubTitle => 'ইমেইল ও পাসওয়ার্ড দিয়ে লগইন করুন';

  @override
  String get signInTEFEmail => 'ইমেইল';

  @override
  String get signInTEFPassword => 'পাসওয়ার্ড';

  @override
  String get signInFilledButtonText => 'সাইন ইন';

  @override
  String get signInNeedAnAccountText => 'অ্যাকাউন্ট নেই?';

  @override
  String get signInTextButtonText => 'সাইন আপ';

  @override
  String get signInEmailValidator => 'একটি সঠিক ইমেইল লিখুন';

  @override
  String get signInPasswordValidator => 'একটি পাসওয়ার্ড লিখুন';

  @override
  String get signInPasswordValidator6Digit => 'ন্যূনতম ৬ অক্ষরের পাসওয়ার্ড লিখুন';

  @override
  String get otpVerificationTitle => 'ওটিপি কোড লিখুন';

  @override
  String get otpVerificationSubTitle => '৪ সংখ্যার একটি ওটিপি কোড পাঠানো হয়েছে';

  @override
  String get otpVerificationFilledButtonText => 'ওটিপি যাচাই করুন';

  @override
  String get otpVerificationTextButtonText => 'কোড আবার পাঠান';
}
