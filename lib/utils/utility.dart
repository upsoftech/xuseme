
import 'dart:math';

import 'package:intl/intl.dart';

class Utility {
 static String formatMongoDateAndTime(String mongoTimeString) {
    DateTime mongoDateTime = DateTime.parse(mongoTimeString).toLocal(); // Convert UTC to local time

    // Format the date and time using the desired format
    String formattedDateTime = DateFormat('dd-MMMM-yyyy h:mm a').format(mongoDateTime);

    return formattedDateTime;
  }
  static String formatMongoDate(String mongoTimeString) {
    DateTime mongoDateTime = DateTime.parse(mongoTimeString).toLocal(); // Convert UTC to local time

    // Format the date and time using the desired format
    String formattedDateTime = DateFormat('dd-MMMM-yyyy').format(mongoDateTime);

    return formattedDateTime;
  }
  static String formatMongoTime(String mongoTimeString) {
    DateTime mongoDateTime = DateTime.parse(mongoTimeString).toLocal(); // Convert UTC to local time

    // Format the date and time using the desired format
    String formattedDateTime = DateFormat('h:mm a').format(mongoDateTime);

    return formattedDateTime;
  }




 static double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
   const double radiusOfEarth = 6371; // Earth's radius in kilometers

   double degreesToRadians(double degrees) {
     return degrees * (pi / 180.0);
   }
   // Convert latitude and longitude from degrees to radians

   final double lat1Rad = degreesToRadians(lat1);
   final double lon1Rad = degreesToRadians(lon1);
   final double lat2Rad = degreesToRadians(lat2);
   final double lon2Rad = degreesToRadians(lon2);

   // Haversine formula
   final double dLat = lat2Rad - lat1Rad;
   final double dLon = lon2Rad - lon1Rad;
   final double a = sin(dLat / 2) * sin(dLat / 2) +
       cos(lat1Rad) * cos(lat2Rad) * sin(dLon / 2) * sin(dLon / 2);
   final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
   final double distance = radiusOfEarth * c;

   return distance.floorToDouble();
 }



}
