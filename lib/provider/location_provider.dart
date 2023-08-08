import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationProvider extends ChangeNotifier {

  /// Constructor
  LocationProvider() {
    getPermission();
  }

  LocationData? locationData;

  List<Placemark>? _placeMark;

  List<Placemark>? get placeMark => _placeMark;

  void getPermission() async {
    if (await Permission.location.isGranted) {
      /// location get ///

      getLocation();
    } else {
      /// permission request ///
      Permission.location.request();
    }
  }

  Future<void> getLocation() async {
    locationData = await loc.Location.instance.getLocation();

    if (locationData != null) {
      _placeMark = await placemarkFromCoordinates(
          locationData!.latitude!, locationData!.longitude!);
   //   log(_placeMark.toString());
      notifyListeners();
    } else {
      getPermission();
    }
  }
}
