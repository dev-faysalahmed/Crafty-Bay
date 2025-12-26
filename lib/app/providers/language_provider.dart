import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier{

  final String _localeKey = 'local';

  Locale _currentLocal = Locale('en');
  Locale get currentLocal => _currentLocal;

  Future<void> loadInitialLanguage()async{
    Locale locale = await _getLocale();

    _currentLocal = locale;
    notifyListeners();

  }

  void changeLocal(Locale newLocal){
    if(_currentLocal == newLocal) return;
    _currentLocal = newLocal;
    _saveLocale(_currentLocal.languageCode);
    notifyListeners();
  }

  Future<void> _saveLocale(String local)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_localeKey, local);
  }

  Future<Locale> _getLocale()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String saveLocal = sharedPreferences.getString(_localeKey) ?? 'en';
    return Locale(saveLocal);
  }

}