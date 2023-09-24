import 'package:flutter/material.dart';

import '../services/preference_services.dart';
import '../constant/app_constants.dart';


class PrefProvider extends ChangeNotifier {
  final PrefService _prefService = PrefService();

  /// getting RegId ///
  Future<void> getRegId() async {
    AppConstant.regId = await _prefService.getRegId();
    notifyListeners();
  }
  /// getting Token ///
  Future<void> getToken() async {
    AppConstant.token = await _prefService.getToken() ??"";
    notifyListeners();
  }
  /// getting Mobile ///
  Future<void> getMobile() async {
    AppConstant.mobile = await _prefService.getMobile();
    notifyListeners();
  }

  /// getting User Session ///
  Future<void> getUserSession() async {
    AppConstant.userSession = await _prefService.getUserSession() ?? false;
    notifyListeners();
  }
}
