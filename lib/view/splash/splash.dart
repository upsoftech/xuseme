import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../constant/image.dart';
import '../../provider/preference_provider.dart';
import '../../services/preference_services.dart';
import '../auth/login_screen.dart';
import '../navigation/navigation_page.dart';

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
    var regId = p.getRegId();
    log(token.toString());
    log(regId.toString());

    if (token != "" && token != null && regId != null) {
      _navigateHome();
    } else {
      _navigateLogin();
    }
  }

  _navigateHome() async {
    await Future.delayed(const Duration(seconds: 4), () {});
    // ignore: use_build_context_synchronously
    Get.to(() => const NavigationPage());
  }

  _navigateLogin() async {
    await Future.delayed(const Duration(seconds: 4), () {});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<PrefProvider>(context);
    return Scaffold(
        body: Column(
          children: [
            const Spacer(),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    splashImages,
                  ),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 100,
              child: Center(
                child: Text(
                  "Powered by SAPIX Technologies",
                  style: GoogleFonts.alice(fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
            )
          ],
        ));
  }
}
