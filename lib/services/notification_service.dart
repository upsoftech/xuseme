import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  Future<void> sendNotification() async {
    var token = await FirebaseMessaging.instance.getToken();
    try {
      //Send  Message
      http.Response response =
          await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
              headers: <String, String>{
                'Content-Type': 'application/json',
                'Authorization':
                    'key=AAAAUCiwpdI:APA91bECAplXrrZ-yvdlPu9g-cFoT5W3i6uR0O3MSNidefvpBP3uPrH_JGsV2ydayII0hrMo5uMwQilKM4qo_J31FNjsOIHaoSHic6BpFlbBCkTxrCMXdoRKfD12BrJpbDcpGgz_Zu1R',
              },
              body: jsonEncode(
                <String, dynamic>{
                  "priority": "high",
                  "notification": {
                    "sound": "default",
                    "body": "Test Notification body",
                    "title": "Test Notification title"
                  },
                  'data': <String, dynamic>{
                    'name': "appointment.name",
                    'time': "appointment.time.toString()",
                    'service': "appointment.service",
                    'status': "appointment.status",
                    'id': "appointment.id"
                  },
                  'to': token
                  //"dZJQSDpURY-oyjRYaKDG2X:APA91bGp2ea1cfftUn-ekAhEBW8hbl-MwooyKaE6LqTkG49XbAMd-dHkGxcGoOAVKbDK2yPKCAOq5hakJlxJQa3U6BBOd5euWaNGnpf4apWzHI2Ud4lSlF7y262iNW2wA1-nwmG2focD"
                },
              ));

      log("status: ${response.body} | Message Sent Successfully!");
    } catch (e) {
      log("error push notification $e");
    }
  }
}
