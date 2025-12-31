import 'package:crafty_bay/app/setup_network_caller.dart';
import 'package:crafty_bay/app/urls.dart';
import 'package:crafty_bay/core/services/network_caller.dart';
import 'package:crafty_bay/features/auth/data/models/sign_in_params.dart';
import 'package:crafty_bay/features/auth/data/models/sign_up_params.dart';
import 'package:crafty_bay/features/auth/data/models/user_model.dart';
import 'package:crafty_bay/features/auth/data/models/verify_otp_params.dart';
import 'package:crafty_bay/features/auth/presentation/providers/auth_controller.dart';
import 'package:flutter/cupertino.dart';

class SignInProvider extends ChangeNotifier {
  bool _isSignInInProgress = false;
  String? _errorMassage;

  bool get isSignInInProgress => _isSignInInProgress;
  String? get errorMassage => _errorMassage;

  Future<bool> signIn(SignInParams signInParams) async {
    bool isSuccess = false;

    _isSignInInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().postRequest(
      url: Urls.signInUrl,
      body: signInParams.toJson(),
    );

    if(response.isSuccess){
      UserModel userModel = UserModel.fromJson(response.responseData['data']['user']);
      String token = response.responseData['data']['token'];
      await AuthController.saveUserData(token, userModel);
      isSuccess = true;
      _errorMassage = null;
    }else{
      _errorMassage = response.errorMessage;
    }

    _isSignInInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
