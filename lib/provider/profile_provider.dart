import 'dart:developer';

import 'package:flutter/cupertino.dart';
import '../services/api_services.dart';
import '../model/address_model.dart';

Set<int> addAddressList = {};

class ProfileProvider extends ChangeNotifier {
  final ApiServices _apiServices = ApiServices();

  bool _isLoading = false;

  Map _profileData = {};
  Map _vendorProfileData = {};
  dynamic _postCosting = {};

  dynamic get postCosting => _postCosting;

  List<AddressModel> _addressList = [];

  List<AddressModel> get addressList => _addressList;

  bool get isLoading => _isLoading;

  dynamic get profileData => _profileData;
  dynamic get vendorProfileData => _vendorProfileData;

  Future<dynamic> getProfile() async {
    await _apiServices.getProfile().then((value) {
      _profileData = value;
      notifyListeners();
    });
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getAddress() async {
    _isLoading = true;
    _addressList.clear();
    await _apiServices.userAddress().then((value) {
      _addressList = value;
      notifyListeners();
    });
  }

  Future<void> removeAddress(int i) async {
    addressList.removeAt(i);
    notifyListeners();
  }

  /// Get Vendor Profile with provider  ///

  Future<dynamic> vendorProfile() async {
    await _apiServices.getVendorProfile().then((value) {
      log("message$value");
      _vendorProfileData = value;
      notifyListeners();
    });
    _isLoading = false;
    notifyListeners();
  }

  /// Get Post Costing
  Future<dynamic> getPostCosting() async {
    await _apiServices.getPostCosting().then((value) {
      log("message$value");
      _postCosting = value;
      notifyListeners();
    });
    _isLoading = false;
    notifyListeners();
  }
}
