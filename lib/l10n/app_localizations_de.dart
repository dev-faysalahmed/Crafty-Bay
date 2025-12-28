// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get signUpTitle => 'Registrieren';

  @override
  String get signUpSubTitle => 'Starten Sie mit Ihren Angaben';

  @override
  String get signUpTEFFirstName => 'Vorname';

  @override
  String get signUpTEFLastName => 'Nachname';

  @override
  String get signUpTEFEmail => 'E-Mail';

  @override
  String get signUpTEFPassword => 'Passwort';

  @override
  String get signUpTEFPhone => 'Telefonnummer';

  @override
  String get signUpTEFCity => 'Stadt';

  @override
  String get signUpFilledButtonText => 'Registrieren';

  @override
  String get signUpAlreadyAccountText => 'Haben Sie bereits ein Konto?';

  @override
  String get signUpTextButtonText => 'Anmelden';

  @override
  String get signUpFirstNameValidator => 'Bitte geben Sie Ihren Vornamen ein';

  @override
  String get signUpLastNameValidator => 'Bitte geben Sie Ihren Nachnamen ein';

  @override
  String get signUpEmailValidator => 'Bitte eine gültige E-Mail-Adresse eingeben';

  @override
  String get signUpPasswordValidator => 'Bitte ein Passwort eingeben';

  @override
  String get signUpPasswordValidator6Digit => 'Bitte ein Passwort mit mindestens 6 Zeichen eingeben';

  @override
  String get signUpPhoneValidator => 'Bitte eine Telefonnummer eingeben';

  @override
  String get signUpCityValidator => 'Bitte geben Sie Ihre Stadt ein';

  @override
  String get signInTitle => 'Anmelden';

  @override
  String get signInSubTitle => 'Melden Sie sich mit E-Mail und Passwort an';

  @override
  String get signInTEFEmail => 'E-Mail';

  @override
  String get signInTEFPassword => 'Passwort';

  @override
  String get signInFilledButtonText => 'Anmelden';

  @override
  String get signInNeedAnAccountText => 'Noch kein Konto?';

  @override
  String get signInTextButtonText => 'Registrieren';

  @override
  String get signInEmailValidator => 'Bitte eine gültige E-Mail eingeben';

  @override
  String get signInPasswordValidator => 'Bitte ein Passwort eingeben';

  @override
  String get signInPasswordValidator6Digit => 'Bitte ein Passwort mit mindestens 6 Zeichen eingeben';

  @override
  String get otpVerificationTitle => 'OTP-Code eingeben';

  @override
  String get otpVerificationSubTitle => 'Ein 4-stelliger OTP-Code wurde gesendet';

  @override
  String get otpVerificationFilledButtonText => 'Weiter';

  @override
  String get otpVerificationTextButtonText => 'Code erneut senden';
}
