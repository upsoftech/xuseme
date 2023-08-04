import 'package:flutter/material.dart';
import '../../constant/image.dart';
import '../login_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigethome();
  }

  _navigethome() async {
    await Future.delayed(const Duration(seconds:4), () {});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration:  const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(splashImages,),
            ),
          ),
        )

    );
  }
}
