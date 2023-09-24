import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../services/api_services.dart';

class HomeProvider extends ChangeNotifier {
  final ApiServices _apiServices = ApiServices();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List _bannerList = [];

  List get bannerList => _bannerList;

  List _singleBannerList = [];

  List get singleBannerList => _singleBannerList;

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  Future<dynamic> getBanner() async {
    _isLoading = true;
    log("message$getBanner");
    await _apiServices.getBanner().then((value) {
      _bannerList = value;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<dynamic> getSingleBanner() async {
    _isLoading = true;

    await _apiServices.getSingleBanner().then((value) {
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
