import 'package:crafty_bay/features/product/data/models/product_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../../app/setup_network_caller.dart';
import '../../../../app/urls.dart';
import '../../../../core/services/network_caller.dart';

class ProductListBySlugProvider extends ChangeNotifier{

  // যেহেতু read product by slug api কাজ করছে না। সুতরাং Category এর ID নিয়ে কাজ করা হয়েছে।

  final int _pageSize = 20;
  int _currentPageNo = 0;
  int? _lastPageNo;

  bool _initialLoading = false;
  bool _loadingMoreData = false;

  final List<ProductModel> _productList = [];

  List<ProductModel> get productList => _productList;
  bool get initialLoading => _initialLoading;
  bool get moreLoading => _loadingMoreData;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> fetchProductList(String slug)async{
    bool isSuccess = false;

    if(_currentPageNo == 0){
      _productList.clear();
      _initialLoading = true;
    }else if(_currentPageNo < _lastPageNo!){
      _loadingMoreData = true;
    }else{
      return false;
    }
    notifyListeners();
    _currentPageNo++;

    final NetworkResponse response = await getNetworkCaller().getRequest(url: Urls.getProductListBySlugUrl(_pageSize, _currentPageNo, slug));

    if(response.isSuccess){
      _lastPageNo ??= response.responseData['data']['last_page'];

      List<ProductModel> list = [];
      for(Map<String, dynamic> product in response.responseData['data']['results']){
        list.add(ProductModel.fromJson(product));
      }

      _productList.addAll(list);
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

  Future<void> loadInitialProductList(String slug)async{
    _currentPageNo = 0;
    _lastPageNo = null;
    await fetchProductList(slug);
  }
}