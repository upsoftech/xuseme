import 'package:flutter/cupertino.dart';
import '../api_services/api_services.dart';
import '../model/address_model.dart';


Set<int> addAddressList = {};

class ProfileProvider extends ChangeNotifier {
  final ApiServices _apiServices = ApiServices();

  bool _isLoading = false;

  Map _profileData = {};

  List<AddressModel> _addressList = [];

  List<AddressModel> get addressList => _addressList;

  bool get isLoading => _isLoading;

  dynamic get profileData => _profileData;



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
}
