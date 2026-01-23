import 'package:crafty_bay/app/setup_network_caller.dart';
import 'package:crafty_bay/app/urls.dart';
import 'package:crafty_bay/core/services/network_caller.dart';
import 'package:flutter/foundation.dart';

class AddReviewProvider extends ChangeNotifier{

  bool _addReviewInProgress = false;
  bool get addReviewInProgress => _addReviewInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> addReview({required String productId, required String review, required String rating})async{
    bool isSuccess = true;

    _addReviewInProgress = true;
    notifyListeners();

    Map<String, dynamic> requestBody = {
      "product": productId,
      "comment":review,
      "rating":rating
    };

    NetworkResponse response = await getNetworkCaller().postRequest(url: Urls.addReviewUrl, body: requestBody);

    if(response.isSuccess){
      isSuccess = true;
      _errorMessage = null;
    }else{
      _errorMessage = response.errorMessage!;
    }

    _addReviewInProgress = false;
    notifyListeners();

    return isSuccess;
  }


}