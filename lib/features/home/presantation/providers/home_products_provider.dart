import 'package:crafty_bay/app/setup_network_caller.dart';
import 'package:crafty_bay/app/urls.dart';
import 'package:crafty_bay/core/services/network_caller.dart';
import 'package:crafty_bay/features/product/data/models/product_model.dart';
import 'package:flutter/cupertino.dart';

class HomeProductsProvider extends ChangeNotifier{
  //============ Popular ==============
  bool _getPopularListInProgress = false;
  bool get getPopularListInProgress => _getPopularListInProgress;
  
  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;
  
  Future<void> getPopularProductList()async{

    _getPopularListInProgress = true;
    notifyListeners();
    
    NetworkResponse response = await getNetworkCaller().getRequest(url: Urls.getHome10ProductListUrl('67c35af85e8a445235de197b'));

    if(response.isSuccess){

      List<ProductModel> list = [];
      for(Map<String, dynamic> map in response.responseData['data']['results']){
        list.add(ProductModel.fromJson(map));
      }

      _popularProductList = list;
    }

    _getPopularListInProgress = false;
    notifyListeners();
  }

  //============ Special ==============

  bool _getSpecialListInProgress = false;
  bool get getSpecialListInProgress => _getSpecialListInProgress;

  List<ProductModel> _specialProductList = [];
  List<ProductModel> get specialProductList => _specialProductList;

  Future<void> getSpecialProductList()async{

    _getSpecialListInProgress = true;
    notifyListeners();

    NetworkResponse response = await getNetworkCaller().getRequest(url: Urls.getHome10ProductListUrl('67c35b395e8a445235de197e'));

    if(response.isSuccess){

      List<ProductModel> list = [];
      for(Map<String, dynamic> map in response.responseData['data']['results']){
        list.add(ProductModel.fromJson(map));
      }

      _specialProductList = list;
    }

    _getSpecialListInProgress = false;
    notifyListeners();
  }


  //============ New ==============

  bool _getNewListInProgress = false;
  bool get getNewListInProgress => _getNewListInProgress;

  List<ProductModel> _newProductList = [];
  List<ProductModel> get newProductList => _newProductList;

  Future<void> getNewProductList()async{

    _getNewListInProgress = true;
    notifyListeners();

    NetworkResponse response = await getNetworkCaller().getRequest(url: Urls.getHome10ProductListUrl('67c7bec4623a876bc4766fea'));

    if(response.isSuccess){

      List<ProductModel> list = [];
      for(Map<String, dynamic> map in response.responseData['data']['results']){
        list.add(ProductModel.fromJson(map));
      }

      _newProductList = list;
    }

    _getNewListInProgress = false;
    notifyListeners();
  }
  
}