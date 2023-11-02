import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:xuseme/provider/category_provider.dart';
import 'package:xuseme/provider/home_provider.dart';
import 'package:xuseme/provider/inquiry_provider.dart';
import 'package:xuseme/provider/location_provider.dart';
import 'package:xuseme/provider/preference_provider.dart';
import 'package:xuseme/provider/profile_provider.dart';
import 'package:xuseme/provider/sub_category_provider.dart';
import 'package:xuseme/services/notification_service.dart';
import 'package:xuseme/view/splash/splash.dart';

import 'services/preference_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await PrefService.init();
  await NotificationService.init();

  runApp(const MyApp());
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
