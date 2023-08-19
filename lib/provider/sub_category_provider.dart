import 'package:flutter/material.dart';
import 'package:xuseme/api_services/api_services.dart';

import '../model/sub_category_model.dart';

class SubShopsProvider extends ChangeNotifier {
  final ApiServices _apiServices = ApiServices();

  bool _isLoading = false;

  List<ShopSubCategoryModel> _subShopList = [];

  List<ShopSubCategoryModel> get subShopList => _subShopList;

  bool get isLoading => _isLoading;

  Future<void> getShopData(Map<String,dynamic> filter) async {
    _isLoading = true;
    _subShopList.clear();
    await _apiServices.getShopData(filter).then((value) {
      _subShopList = value;
      _isLoading = false;
      notifyListeners();
    });
  }
}
