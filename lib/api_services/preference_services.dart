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
    return setString(AppConstants.regIdKey, regId);
  }

  setSelectType(String types) {
    return setString(AppConstants.selectType, types);
  }

  setSelectToken(String tokens) {
    return setString(AppConstants.saveToken, tokens);
  }

  getSelectType() {
    return getString(AppConstants.selectType);
  }

  getRegId() {
    return getString(AppConstants.regIdKey);
  }

  getToken() {
    return getString(AppConstants.saveToken);
  }

  setMobile(String mobile) {
    return setString(AppConstants.mobileNoKey, mobile);
  }

  getMobile() {
    return getString(AppConstants.mobileNoKey);
  }

  setUserSession(bool value) {
    return setBool(AppConstants.userSessionKey, value);
  }

  getUserSession() {
    return getBool(AppConstants.userSessionKey);
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
