import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../services/api_services.dart';

class HomeProvider extends ChangeNotifier {
  final ApiServices _apiServices = ApiServices();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List _topBannerList = [];

  List get topBannerList => _topBannerList;

  List _bottomBannerList = [];

  List get bottomBannerList => _bottomBannerList;

  List _singleBannerList = [];

  List get singleBannerList => _singleBannerList;

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  Future<dynamic> getTopBanner(latitude, longitude) async {
    _isLoading = true;


    await _apiServices.getBanner(isTop: true,latitude: latitude,longitude: longitude).then((value) {
      log("messageTopBanner : $value");
      _topBannerList = value;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<dynamic> getBottomBanner(latitude,longitude) async {
    _isLoading = true;


    await _apiServices.getBanner(latitude: latitude,longitude: longitude).then((value) {
      log("messageBottomBanner :$value");
      _bottomBannerList = value;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<dynamic> getSingleBanner(latitude,longitude) async {
    _isLoading = true;

    await _apiServices.getSingleBanner(latitude: latitude,longitude: longitude).then((value) {
      _singleBannerList = value;
      _isLoading = false;
      notifyListeners();
    });
  }

  setCurrentIndex(int i) {
    _currentIndex = i;
    notifyListeners();
  }
}
