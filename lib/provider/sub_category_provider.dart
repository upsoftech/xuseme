import 'package:flutter/material.dart';
import 'package:xuseme/services/api_services.dart';

import '../model/sub_category_model.dart';

class SubShopsProvider extends ChangeNotifier {
  final ApiServices _apiServices = ApiServices();

  bool _isLoading = false;

  List<ShopSubCategoryModel> _subShopList = [];

  List<ShopSubCategoryModel> get subShopList => _subShopList;
  ShopSubCategoryModel? _vendorData;

  ShopSubCategoryModel? get vendorData => _vendorData;

  bool get isLoading => _isLoading;

  Future<void> getShopData(Map<String, dynamic> filter) async {
    _isLoading = true;
    _subShopList.clear();
    await _apiServices.getShopData(filter).then((value) {
      _subShopList = value;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> getVendorById(String id) async {
    _isLoading = true;
    _subShopList.clear();
    await _apiServices.getVendorDetailsById(id).then((value) {
      _vendorData = value;
      _isLoading = false;
      notifyListeners();
    });
  }
}
