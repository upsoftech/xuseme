import 'package:flutter/material.dart';

import '../api_services/preference_services.dart';
import '../constant/app_constants.dart';


class PrefProvider extends ChangeNotifier {
  final PrefService _prefService = PrefService();

  /// getting RegId
  Future<void> getRegId() async {
    AppConstants.regId = await _prefService.getRegId();
    notifyListeners();
  }
  /// getting Token
  Future<void> getToken() async {
    AppConstants.token = await _prefService.getToken() ??"";
    notifyListeners();
  }
  /// getting Mobile
  Future<void> getMobile() async {
    AppConstants.mobile = await _prefService.getMobile();
    notifyListeners();
  }

  /// getting User Session
  Future<void> getUserSession() async {
    AppConstants.userSession = await _prefService.getUserSession() ?? false;
    notifyListeners();
  }
}
