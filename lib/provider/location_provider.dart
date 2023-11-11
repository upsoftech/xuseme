import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
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
  geocoding.Location? _geocodingLocation;

  geocoding.Location? get geocodingLocation => _geocodingLocation;

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
    if (await Permission.location.isGranted) {
      locationData = await loc.Location.instance.getLocation();
      notifyListeners();

      if (locationData != null) {
        _placeMark = await placemarkFromCoordinates(
            locationData!.latitude!, locationData!.longitude!);
        //   log(_placeMark.toString());
        notifyListeners();
      } else {
        getPermission();
      }
    } else {
      /// permission request ///
      Permission.location.request();
    }
  }

  Future<void> getCoordinatesFromAddress(String address) async {
    try {
      List<geocoding.Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        geocoding.Location location = locations.first;
        double latitude = location.latitude;
        double longitude = location.longitude;
        print("Latitude: $latitude, Longitude: $longitude");
        _geocodingLocation = location;

        notifyListeners();
      } else {
        print("No location found for the given address");
        throw Exception("No location found for the given address");
      }
    } catch (e) {
      print("Error: $e");
      rethrow; // Rethrow the caught exception
    }
  }
}
