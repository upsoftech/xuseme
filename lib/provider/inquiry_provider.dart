import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:xuseme/model/banner_model.dart';

import '../services/api_services.dart';
import '../model/inquiry_model.dart';

class InquiryProvider extends ChangeNotifier {
  final ApiServices _apiServices = ApiServices();

  bool _isLoading = false;

  List<InquiryModel> _inquiryList = [];
  List<BannerModel> _bannerHistoryList = [];
  List<dynamic> _offerAdHistoryList = [];

  List<InquiryModel> get inquiryList => _inquiryList;

  List<dynamic> get offerAdHistoryList => _offerAdHistoryList;

  bool get isLoading => _isLoading;

  List<BannerModel> get bannerHistoryList => _bannerHistoryList;

  Future<void> inquiryData({String? type}) async {
    log("message");
    _isLoading = true;
    _inquiryList.clear();
    await _apiServices.userInquiry(type??"v1").then((value) {
      _inquiryList = value;
      _isLoading = false;
      notifyListeners();
    });
  }

  /// Banner History Add ///
  Future<void> bannerHistory() async {
    log("message");
    _isLoading = true;
    await _apiServices.getBannerHistory().then((value) {
      _bannerHistoryList = value;
      _isLoading = false;
      notifyListeners();
    });
  }

  /// GET Publish Offer Ad History
  Future<dynamic> getOfferAdHistory(String id) async {
    _isLoading = true;
    var value = await _apiServices.getOfferAdHistory(id);

    _offerAdHistoryList = value;
    _isLoading = false;
    notifyListeners();

    return value;
  }

  Future<void> removeOfferItem(int i) async {
    _offerAdHistoryList.removeAt(i);
    notifyListeners();
  }

  Future<void> removePremiumAdItem(int i) async {
    _bannerHistoryList.removeAt(i);
    notifyListeners();
  }
}
