import 'package:crafty_bay/app/setup_network_caller.dart';
import 'package:crafty_bay/app/urls.dart';
import 'package:crafty_bay/core/services/network_caller.dart';
import 'package:crafty_bay/features/auth/data/models/user_model.dart';
import 'package:crafty_bay/features/auth/presentation/providers/auth_controller.dart';
import 'package:crafty_bay/features/profile/data/update_profile_param.dart';
import 'package:flutter/foundation.dart';

class UpdateProfileProvider extends ChangeNotifier{

  bool _updateProfileProviderInProgress = false;
  bool get updateProfileProviderInProgress => _updateProfileProviderInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> updateProfile(UpdateProfileParam param)async{
    bool isSuccess = false;

    _updateProfileProviderInProgress = true;
    notifyListeners();
    
    NetworkResponse response = await getNetworkCaller().patchRequest(url: Urls.updateProfileUrl, body: param.toJson());

    if(response.isSuccess){
      isSuccess = true;
      _errorMessage = null;

      AuthController.updateUserData(UserModel.fromJson(response.responseData['data']));
    }else{
      _errorMessage = response.errorMessage;
    }

    _updateProfileProviderInProgress = false;
    notifyListeners();

    return isSuccess;
  }

}