
import 'package:intl/intl.dart';

class Utility {
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


}
