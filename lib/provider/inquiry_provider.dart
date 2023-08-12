import 'dart:developer';

import 'package:flutter/foundation.dart';
import '../api_services/api_services.dart';
import '../model/inquiry_model.dart';

class InquiryProvider extends ChangeNotifier {
  final ApiServices _apiServices = ApiServices();

  bool _isLoading = false;

  List<InquiryModel> _inquiryList = [];

  List<InquiryModel> get inquiryList => _inquiryList;
  bool get isLoading => _isLoading;

  Future<void> inquiryData() async {
  log("message");
    _isLoading = true;
    _inquiryList.clear();
    await _apiServices.userInquiryAddress().then((value){
      _inquiryList=value;
      _isLoading = false;
      notifyListeners();

    });
  }
}
