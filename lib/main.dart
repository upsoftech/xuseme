import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:xuseme/provider/category_provider.dart';
import 'package:xuseme/provider/home_provider.dart';
import 'package:xuseme/provider/inquiry_provider.dart';
import 'package:xuseme/provider/location_provider.dart';
import 'package:xuseme/provider/preference_provider.dart';
import 'package:xuseme/provider/profile_provider.dart';
import 'package:xuseme/provider/sub_category_provider.dart';
import 'package:xuseme/view/splash/splash.dart';

import 'services/preference_services.dart';


FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PrefService.init();
  FirebaseMessaging.instance.getToken().then((value) {
    log("FCM Token : $value");
    PrefService().setFcmToken(value!);
  });

  AndroidInitializationSettings androidSettings = const AndroidInitializationSettings("@mipmap/ic_launcher");

  DarwinInitializationSettings iosSettings = const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestCriticalPermission: true,
      requestSoundPermission: true
  );

  InitializationSettings initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings
  );

  bool? initialized = await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        log(response.payload.toString());
      }
  );

  log("Notifications: $initialized");
  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  /// When App Is Closed Or Terminated
  FirebaseMessaging.instance.getInitialMessage().then((event) {
    (RemoteMessage message) async {
      log("FCM Message : $message");
    };
  });

  /// on open
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    (RemoteMessage message) async {
      log("FCM Message : $message");
    };
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());


}


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle the notification here
  await Firebase.initializeApp();
  log("FCM BG Message : $message");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PrefProvider()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => InquiryProvider()),
        ChangeNotifierProvider(create: (context) => SubShopsProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
      ],
      child: GetMaterialApp(
        title: 'XuseMe',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
