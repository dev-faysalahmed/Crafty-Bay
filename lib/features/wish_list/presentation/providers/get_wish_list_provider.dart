import 'package:crafty_bay/app/setup_network_caller.dart';
import 'package:crafty_bay/app/urls.dart';
import 'package:crafty_bay/core/services/network_caller.dart';
import 'package:crafty_bay/features/product/data/models/product_model.dart';
import 'package:crafty_bay/features/wish_list/data/models/wish_list_model.dart';
import 'package:flutter/foundation.dart';

class GetWishListProvider extends ChangeNotifier{

  bool _getWishListInProgress = false;
  bool get getWishListInProgress => _getWishListInProgress;

  List<WishListModel> _wishList = [];
  List<WishListModel> get wishList => _wishList;

  Future<bool> getWishList()async{
    bool isSuccess = false;

    _getWishListInProgress = true;
    notifyListeners();

    NetworkResponse response = await getNetworkCaller().getRequest(url: Urls.getWishListUrl);

    if(response.isSuccess){
      isSuccess = true;

      List<WishListModel> list = [];

      for(Map<String, dynamic> map in response.responseData['data']['results']){
        list.add(WishListModel.fromJson(map));
      }

      _wishList = list;
    }
    _getWishListInProgress = false;
    notifyListeners();


    return isSuccess;
  }
}