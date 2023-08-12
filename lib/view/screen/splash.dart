import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:xuseme/view/screen/navigation_page.dart';
import '../../api_services/preference_services.dart';
import '../../constant/image.dart';
import '../../provider/preference_provider.dart';
import '../login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final prefProvider = Provider.of<PrefProvider>(context, listen: false);
    prefProvider.getToken();
    var p = PrefService();
    var token = p.getToken();
    log(token.toString());
    if (token != "" && token !=null) {
      _navigethome();
    } else {
      _navigeteLogin();
    }
  }

  _navigethome() async {
    await Future.delayed(const Duration(seconds: 4), () {});
    // ignore: use_build_context_synchronously
    Get.to(const NavigationPage());
  }

  _navigeteLogin() async {
    await Future.delayed(const Duration(seconds: 4), () {});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<PrefProvider>(context);
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            splashImages,
          ),
        ),
      ),
    ));
  }
}
