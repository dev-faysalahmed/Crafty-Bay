import 'package:crafty_bay/app/setup_network_caller.dart';
import 'package:crafty_bay/app/urls.dart';
import 'package:crafty_bay/core/services/network_caller.dart';
import 'package:crafty_bay/features/auth/data/models/sign_up_params.dart';
import 'package:crafty_bay/features/auth/data/models/verify_otp_params.dart';
import 'package:flutter/cupertino.dart';

class VerifyOtpProvider extends ChangeNotifier {
  bool _isVerifyOtpInProgress = false;
  String? _errorMassage;

  bool get isVerifyOtpInProgress => _isVerifyOtpInProgress;
  String? get errorMassage => _errorMassage;

  Future<bool> verifyOtp(VerifyOtpParams otpParams) async {
    bool isSuccess = false;

    _isVerifyOtpInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().postRequest(
      url: Urls.verifyOtpUrl,
      body: otpParams.toJson(),
    );

    if(response.isSuccess){
      isSuccess = true;
      _errorMassage = null;
    }else{
      _errorMassage = response.errorMessage;
    }

    _isVerifyOtpInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
