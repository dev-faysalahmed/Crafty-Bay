import 'package:flutter/material.dart';

import '../../../../app/setup_network_caller.dart';
import '../../../../app/urls.dart';
import '../../../../core/services/network_caller.dart';

class UpdateReviewProvider extends ChangeNotifier{

  bool _updateReviewInProgress = false;
  bool get updateReviewInProgress => _updateReviewInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> updateReview({required String reviewId, required String newReview, required String rating})async{
    bool isSuccess = true;

    _updateReviewInProgress = true;
    notifyListeners();

    Map<String, dynamic> requestBody = {
      "comment":newReview,
      "rating":rating
    };

    NetworkResponse response = await getNetworkCaller().patchRequest(url: Urls.deleteReviewUrl(reviewId), body: requestBody);

    if(response.isSuccess){
      isSuccess = true;
      _errorMessage = null;
    }else{
      _errorMessage = response.errorMessage ?? '';
    }

    _updateReviewInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}