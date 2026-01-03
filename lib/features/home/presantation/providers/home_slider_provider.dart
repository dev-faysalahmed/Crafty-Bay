import 'package:crafty_bay/app/setup_network_caller.dart';
import 'package:crafty_bay/app/urls.dart';
import 'package:crafty_bay/core/services/network_caller.dart';
import 'package:crafty_bay/features/home/data/models/slider_model.dart';
import 'package:flutter/material.dart';

class HomeSliderProvider extends ChangeNotifier {
  bool _getHomeSliderInProgress = false;

  bool get getHomeSliderInProgress => _getHomeSliderInProgress;

  List<SliderModel> _homeSliderList = [];

  List<SliderModel> get homeSliderList => _homeSliderList;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> getHomeSlider() async {
    bool isSuccess = false;

    _getHomeSliderInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().getRequest(
      url: Urls.homeSliderUrl,
    );
    if (response.isSuccess) {
      List<SliderModel> list = [];
      for (Map<String, dynamic> slider
          in response.responseData['data']['results']) {
        list.add(SliderModel.fromJson(slider));
      }
      _homeSliderList = list;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _getHomeSliderInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
