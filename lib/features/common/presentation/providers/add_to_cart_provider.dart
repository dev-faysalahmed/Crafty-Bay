import 'package:crafty_bay/app/setup_network_caller.dart';
import 'package:crafty_bay/app/urls.dart';
import 'package:crafty_bay/core/services/network_caller.dart';
import 'package:flutter/material.dart';

class AddToCartProvider extends ChangeNotifier{

  bool _addToCartInProgress = false;
  bool get addToCartInProgress => _addToCartInProgress;

  String? _errorMessage;
  String?  get errorMessage => _errorMessage;

  Future<bool> addToCart(String productId, int quantity)async{
    bool isSuccess = false;

    _addToCartInProgress = true;
    notifyListeners();

    Map<String, dynamic> requestBody = {
      "product" : productId,
      "quantity" : quantity,
      //"color" : "Blue",
      //"size" : "XL"
    };

    final NetworkResponse response = await getNetworkCaller().postRequest(url: Urls.addToCartUrl, body: requestBody);

    if(response.isSuccess){
      isSuccess = true;
      _errorMessage = null;
    }else{
      _errorMessage = response.errorMessage;
    }

    _addToCartInProgress = false;
    notifyListeners();


    return isSuccess;
  }
  
}