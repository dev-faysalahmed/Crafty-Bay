import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('de'),
    Locale('en')
  ];

  /// No description provided for @signUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpTitle;

  /// No description provided for @signUpSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Get started with your details'**
  String get signUpSubTitle;

  /// No description provided for @signUpTEFFirstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get signUpTEFFirstName;

  /// No description provided for @signUpTEFLastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get signUpTEFLastName;

  /// No description provided for @signUpTEFEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get signUpTEFEmail;

  /// No description provided for @signUpTEFPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get signUpTEFPassword;

  /// No description provided for @signUpTEFPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get signUpTEFPhone;

  /// No description provided for @signUpTEFCity.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get signUpTEFCity;

  /// No description provided for @signUpFilledButtonText.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpFilledButtonText;

  /// No description provided for @signUpAlreadyAccountText.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get signUpAlreadyAccountText;

  /// No description provided for @signUpTextButtonText.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signUpTextButtonText;

  /// No description provided for @signUpFirstNameValidator.
  ///
  /// In en, this message translates to:
  /// **'Enter your first name'**
  String get signUpFirstNameValidator;

  /// No description provided for @signUpLastNameValidator.
  ///
  /// In en, this message translates to:
  /// **'Enter your last name'**
  String get signUpLastNameValidator;

  /// No description provided for @signUpEmailValidator.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get signUpEmailValidator;

  /// No description provided for @signUpPasswordValidator.
  ///
  /// In en, this message translates to:
  /// **'Enter a password'**
  String get signUpPasswordValidator;

  /// No description provided for @signUpPasswordValidator6Digit.
  ///
  /// In en, this message translates to:
  /// **'Enter minimum 6 digit password'**
  String get signUpPasswordValidator6Digit;

  /// No description provided for @signUpPhoneValidator.
  ///
  /// In en, this message translates to:
  /// **'Enter a phone number'**
  String get signUpPhoneValidator;

  /// No description provided for @signUpCityValidator.
  ///
  /// In en, this message translates to:
  /// **'Enter your city'**
  String get signUpCityValidator;

  /// No description provided for @signInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInTitle;

  /// No description provided for @signInSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Login your account with email and password'**
  String get signInSubTitle;

  /// No description provided for @signInTEFEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get signInTEFEmail;

  /// No description provided for @signInTEFPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get signInTEFPassword;

  /// No description provided for @signInFilledButtonText.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInFilledButtonText;

  /// No description provided for @signInNeedAnAccountText.
  ///
  /// In en, this message translates to:
  /// **'Need an Account?'**
  String get signInNeedAnAccountText;

  /// No description provided for @signInTextButtonText.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signInTextButtonText;

  /// No description provided for @signInEmailValidator.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get signInEmailValidator;

  /// No description provided for @signInPasswordValidator.
  ///
  /// In en, this message translates to:
  /// **'Enter a password'**
  String get signInPasswordValidator;

  /// No description provided for @signInPasswordValidator6Digit.
  ///
  /// In en, this message translates to:
  /// **'Enter minimum 6 digit password'**
  String get signInPasswordValidator6Digit;

  /// No description provided for @otpVerificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP Code'**
  String get otpVerificationTitle;

  /// No description provided for @otpVerificationSubTitle.
  ///
  /// In en, this message translates to:
  /// **'A 4 digit otp code has been sent'**
  String get otpVerificationSubTitle;

  /// No description provided for @otpVerificationFilledButtonText.
  ///
  /// In en, this message translates to:
  /// **'Verify OTP'**
  String get otpVerificationFilledButtonText;

  /// No description provided for @otpVerificationTextButtonText.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get otpVerificationTextButtonText;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['bn', 'de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn': return AppLocalizationsBn();
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
