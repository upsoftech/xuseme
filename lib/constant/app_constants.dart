// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

class AppConstants {
  static const String APP_NAME = 'XuseMe';


  /* Height and with */
  static double width(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

  static double height(BuildContext context){
    return MediaQuery.of(context).size.height;
  }


  /// constant variable data

  static String regId="";
  static String mobile="";
  static bool userSession = false;

  /// Shared Preference Keys ///

  static String regIdKey="regIdKey";
  static String mobileNoKey="mobileNoKey";
  static String userSessionKey="userSessionKey";
}




