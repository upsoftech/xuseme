import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:xuseme/services/preference_services.dart';

class NotificationService {
  /// FlutterLocalNotification Instance
  static FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Initialize FlutterLocalNotification && Firebase Messaging
  static Future<void> init() async {
    AndroidInitializationSettings androidSettings =
        const AndroidInitializationSettings("@mipmap/ic_launcher");

    DarwinInitializationSettings iosSettings =
        const DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestCriticalPermission: true,
            requestSoundPermission: true);

    InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    bool? initialized = await notificationsPlugin.initialize(
        initializationSettings, onDidReceiveNotificationResponse: (response) {
      log(response.payload.toString());
    });

    log("Notifications: $initialized");

    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    /// When App Is Closed Or Terminated
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      (RemoteMessage message) async {
        log("FCM Message : $message");
      };
    });
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    /// on open
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      (RemoteMessage message) async {
        log("FCM Message : $message");
      };
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      log("FCM Message Notification Title : ${event.notification?.title}");
      log("FCM Message Notification Body : ${event.notification?.body}");
      log("FCM Message Data : ${event.data}");

      NotificationService.showLocalNotification(event.notification?.title ?? "",
          event.notification?.body ?? "", event.data);
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  /// Show FlutterLocalNotification
  static Future<void> showLocalNotification(
      String title, String body, Map<String, dynamic> mapData) async {



    AndroidNotificationDetails androidDetails =
        const AndroidNotificationDetails(
            "com.xuseme#push-notification-channel-id",
            "com.xuseme#push-notification-channel-name",
            priority: Priority.max,
            importance: Importance.max,
            sound: RawResourceAndroidNotificationSound("double_ping"));

    DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    notificationsPlugin.show(3, title, body, notificationDetails);
  }

  /// Sending Notification Using Firebase
  static Future<void> sendNotification() async {
    var token = await FirebaseMessaging.instance.getToken();

    log("My Token : ${token.toString().trim()}");
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
                    "body": "Notification body",
                    "title": "Notification title"
                  },
                  'data': <String, dynamic>{
                    'title': "appointment.name",
                    'subtitle': "appointment.time.toString()",
                    'message': "appointment.service",
                  },
                  'to': token
                  //"dxLJPri1SCisT3Xv39LWhj:APA91bE_ex7KZuEhT76tt-Q5ZmeziSx-9aWrEkLi_XU3t7--a5EA-z60Vw1DCHlNiAz1ZgLWQQg0c_qM0u2lQAutqW_2MlijOlkypyleVwJQvSSyhRQl2ynWUMMDnYmqiRASr6oz7D2E"
                },
              ));

      log("status: ${response.body} | Message Sent Successfully!");
    } catch (e) {
      log("error push notification $e");
    }
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle the notification here
  await Firebase.initializeApp();
  log("FCM BG Message : $message");
  NotificationService.showLocalNotification(message.notification?.title ?? "",
      message.notification?.body ?? "", message.data);
}


