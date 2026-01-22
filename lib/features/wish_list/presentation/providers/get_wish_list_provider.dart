import 'package:crafty_bay/app/setup_network_caller.dart';
import 'package:crafty_bay/app/urls.dart';
import 'package:crafty_bay/core/services/network_caller.dart';
import 'package:crafty_bay/features/category/data/models/category_model.dart';
import 'package:crafty_bay/features/wish_list/data/models/wish_list_model.dart';
import 'package:flutter/material.dart';

class GetWishListProvider extends ChangeNotifier{

  final int _pageSize = 18;
  int _currentPageNo = 0;
  int? _lastPageNo;

  bool _initialLoading = false;
  bool _loadingMoreData = false;

  final List<WishListModel> _wishList = [];

  List<WishListModel> get wishList => _wishList;
  bool get initialLoading => _initialLoading;
  bool get moreLoading => _loadingMoreData;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> fetchWishList()async{
    bool isSuccess = false;

    if(_currentPageNo == 0){
      _wishList.clear();
      _initialLoading = true;
    }else if(_currentPageNo < _lastPageNo!){
      _loadingMoreData = true;
    }else{
      return false;
    }
    notifyListeners();
    _currentPageNo++;

    final NetworkResponse response = await getNetworkCaller().getRequest(url: Urls.getWishListUrl(_pageSize, _currentPageNo));

    if(response.isSuccess){
      _lastPageNo ??= response.responseData['data']['last_page'];

      List<WishListModel> list = [];
      for(Map<String, dynamic> wishItem in response.responseData['data']['results']){
        list.add(WishListModel.fromJson(wishItem));
      }

      _wishList.addAll(list);
      isSuccess = true;
    }else{
      _errorMessage = response.errorMessage;
    }

    if(_initialLoading){
      _initialLoading = false;
    }else{
      _loadingMoreData = false;
    }
    notifyListeners();

    return isSuccess;
  }

  Future<void> loadInitialWishList()async{
    _currentPageNo = 0;
    _lastPageNo = null;
    await fetchWishList();
  }

}