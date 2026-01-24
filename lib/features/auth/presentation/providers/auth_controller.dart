import 'dart:convert';

import 'package:crafty_bay/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {

  static const String _tokenKey = 'access-token';
  static const String _userKey = 'user-data';

  static UserModel? userModel;
  static String? accessToken;

  static Future<void> saveUserData(String token, UserModel model)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_tokenKey, token);
    await sharedPreferences.setString(_userKey, jsonEncode(model.toJson()));

    userModel = model;
    accessToken = token;
  }

  static Future<void> getUserData()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    accessToken = sharedPreferences.getString(_tokenKey);
    if(accessToken != null){
      String? encodedUserData = sharedPreferences.getString(_userKey);
      if(encodedUserData != null){
        userModel = UserModel.fromJson(jsonDecode(encodedUserData));
      }
    }
  }

  static Future<bool> isAlreadyLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_tokenKey) != null;
  }

  static Future<void> clearUserData()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  static Future<void> updateUserData(UserModel model)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userKey, jsonEncode(model.toJson()));

    userModel =  model;
  }


}