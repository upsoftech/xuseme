import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:xuseme/provider/home_provider.dart';
import 'package:xuseme/provider/location_provider.dart';
import 'package:xuseme/provider/preference_provider.dart';
import 'package:xuseme/provider/profile_provider.dart';
import 'package:xuseme/view/screen/splash.dart';

import 'api_services/preference_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>PrefProvider()),
        ChangeNotifierProvider(create: (context)=>LocationProvider()),
        ChangeNotifierProvider(create: (context)=>HomeProvider()),
        ChangeNotifierProvider(create: (context)=>ProfileProvider()),
      ],
      child: GetMaterialApp(
        title: 'XuseMe',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

