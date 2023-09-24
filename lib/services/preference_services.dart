import 'package:shared_preferences/shared_preferences.dart';

import '../constant/app_constants.dart';

class PrefService {
  static late SharedPreferences _prefs;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  setRegId(String regId) {
    return setString(AppConstant.regIdKey, regId);
  }

  setSelectType(String types) {
    return setString(AppConstant.selectType, types);
  }

  setSelectToken(String tokens) {
    return setString(AppConstant.saveToken, tokens);
  }

  setFcmToken(String tokens) {
    return setString(AppConstant.fcmToken, tokens);
  }

  getSelectType() {
    return getString(AppConstant.selectType);
  }

  getRegId() {
    return getString(AppConstant.regIdKey);
  }

  getToken() {
    return getString(AppConstant.saveToken);
  }
  getFcmToken() {
    return getString(AppConstant.fcmToken);
  }

  setMobile(String mobile) {
    return setString(AppConstant.mobileNoKey, mobile);
  }

  getMobile() {
    return getString(AppConstant.mobileNoKey);
  }

  setUserSession(bool value) {
    return setBool(AppConstant.userSessionKey, value);
  }

  getUserSession() {
    return getBool(AppConstant.userSessionKey);
  }

  //sets
  static Future<bool> setBool(String key, bool value) async =>
      await _prefs.setBool(key, value);

  static Future<bool> setDouble(String key, double value) async =>
      await _prefs.setDouble(key, value);

  static Future<bool> setInt(String key, int value) async =>
      await _prefs.setInt(key, value);

  static Future<bool> setString(String key, String value) async =>
      await _prefs.setString(key, value);

  static Future<bool> setStringList(String key, List<String> value) async =>
      await _prefs.setStringList(key, value);

  //gets
  static bool? getBool(String key) => _prefs.getBool(key);

  static double? getDouble(String key) => _prefs.getDouble(key);

  static int? getInt(String key) => _prefs.getInt(key);

  static String? getString(String key) => _prefs.getString(key);

  static List<String>? getStringList(String key) => _prefs.getStringList(key);

  //deletes..
  static Future<bool> remove(String key) async => await _prefs.remove(key);

  static Future<bool> clear() async => await _prefs.clear();
}
