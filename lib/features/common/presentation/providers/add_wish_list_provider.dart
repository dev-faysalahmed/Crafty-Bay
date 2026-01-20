import 'package:crafty_bay/app/setup_network_caller.dart';
import 'package:crafty_bay/app/urls.dart';
import 'package:crafty_bay/core/services/network_caller.dart';
import 'package:flutter/foundation.dart';

class AddWishListProvider extends ChangeNotifier{

  bool _addWishListInProgress = false;
  bool get addWishListInProgress => _addWishListInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> addWishList({required String productId})async{
    bool isSuccess = false;

    _addWishListInProgress = true;
    notifyListeners();

    Map<String, dynamic> requestBody = {"product" : productId};

    NetworkResponse response = await getNetworkCaller().postRequest(url: Urls.addWishListUrl, body: requestBody);

    if(response.isSuccess){
      isSuccess = true;
      _errorMessage = null;
    }else{
      _errorMessage = response.errorMessage!;
    }

    _addWishListInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}