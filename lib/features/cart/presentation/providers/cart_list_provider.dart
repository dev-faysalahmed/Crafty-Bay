import 'package:crafty_bay/app/setup_network_caller.dart';
import 'package:crafty_bay/app/urls.dart';
import 'package:crafty_bay/core/services/network_caller.dart';
import 'package:crafty_bay/features/cart/data/models/cart_model.dart';
import 'package:flutter/material.dart';

class CartListProvider extends ChangeNotifier {
  bool _getCartListInProgress = false;

  bool get getCartListInProgress => _getCartListInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  double _totalPayableAmount = 0;

  double get totalPayableAmount => _totalPayableAmount;

  List<CartModel> _cartList = [];

  List<CartModel> get cartList => _cartList;

  Future<bool> getCartList() async {
    bool isSuccess = false;

    _getCartListInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().getRequest(
      url: Urls.getCartListUrl,
    );

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;

      _totalPayableAmount = 0;

      List<CartModel> list = [];
      for (Map<String, dynamic> map
          in response.responseData['data']['results']) {
        var productPrice = map['product']['current_price'];
        var quantity = map['quantity'];
        _totalPayableAmount = _totalPayableAmount + productPrice * quantity;
        list.add(CartModel.fromJson(map));
      }

      _cartList = list;

      _getCartListInProgress = false;
      notifyListeners();
    } else {
      _errorMessage = response.errorMessage!;
    }

    return isSuccess;
  }

  bool _updateCartItemInProgress = false;
  bool get updateCartItemInProgress => _updateCartItemInProgress;

  Future<bool> updateCartItem({required String cartId, required int quantity})async{
    bool isSuccess = false;

    _updateCartItemInProgress = true;
    notifyListeners();

    Map<String, dynamic> requestBody = {"quantity": quantity};

    NetworkResponse response = await getNetworkCaller().patchRequest(url: Urls.updateCartItemUrl(cartId), body: requestBody);

    if(response.isSuccess){
      isSuccess = true;
      getCartList();
    }

    _updateCartItemInProgress = false;
    notifyListeners();



    return isSuccess;
  }

}
