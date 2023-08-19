import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:xuseme/model/banner_model.dart';
import '../api_services/api_services.dart';
import '../model/inquiry_model.dart';

class InquiryProvider extends ChangeNotifier {
  final ApiServices _apiServices = ApiServices();

  bool _isLoading = false;

  List<InquiryModel> _inquiryList = [];
  List<BannerModel> _bannerHistoryList = [];

  List<InquiryModel> get inquiryList => _inquiryList;
  bool get isLoading => _isLoading;


  List<BannerModel> get bannerHistoryList => _bannerHistoryList;


  Future<void> inquiryData(String type) async {
    log("message");
    _isLoading = true;
    _inquiryList.clear();
    await _apiServices.userInquiry(type).then((value) {
      _inquiryList = value;
      _isLoading = false;
      notifyListeners();
    });
  }
    /// Banner History Add ///
  Future<void> bannerHistory() async {
    log("message");
    _isLoading = true;
    await _apiServices.getBannerHistory().then((value){
      _bannerHistoryList=value;
      _isLoading = false;
      notifyListeners();

    });

  }
}
