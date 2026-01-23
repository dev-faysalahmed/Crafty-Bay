import 'package:crafty_bay/features/product_review/data/models/review_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../../app/setup_network_caller.dart';
import '../../../../app/urls.dart';
import '../../../../core/services/network_caller.dart';

class ReviewProvider extends ChangeNotifier{

  final int _pageSize = 20;
  int _currentPageNo = 0;
  int? _lastPageNo;

  int _totalReviewCount = 0;
  int get totalReviewCount => _totalReviewCount;


  bool _initialLoading = false;
  bool _loadingMoreData = false;

  final List<ReviewModel> _reviewList = [];

  List<ReviewModel> get reviewList => _reviewList;
  bool get initialLoading => _initialLoading;
  bool get moreLoading => _loadingMoreData;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> fetchReviewList(String productId)async{
    bool isSuccess = false;

    if(_currentPageNo == 0){
      _reviewList.clear();
      _initialLoading = true;
    }else if(_currentPageNo < _lastPageNo!){
      _loadingMoreData = true;
    }else{
      return false;
    }
    notifyListeners();
    _currentPageNo++;

    final NetworkResponse response = await getNetworkCaller().getRequest(url: Urls.getReviewsByProductIdUrl(_pageSize, _currentPageNo, productId));

    if(response.isSuccess){
      _lastPageNo ??= response.responseData['data']['last_page'];

      _totalReviewCount = response.responseData['data']['total'];

      List<ReviewModel> list = [];
      for(Map<String, dynamic> product in response.responseData['data']['results']){
        list.add(ReviewModel.fromJson(product));
      }

      _reviewList.addAll(list);
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

  Future<void> loadInitialReviewList(String productId)async{
    _currentPageNo = 0;
    _lastPageNo = null;
    await fetchReviewList(productId);
  }
}