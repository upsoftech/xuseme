import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:xuseme/view/auth/location.dart';

import '../../services/api_services.dart';
import '../../services/preference_services.dart';
import '../../constant/color.dart';
import '../navigation/navigation_page.dart';
import '../vendor/vandor_registration.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key, required this.dropdownValue, required this.mobile})
      : super(key: key);
  final String dropdownValue;
  final String mobile;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

int secondsRemaining = 30;
bool enableResend = false;
Timer? timer;

class _OtpScreenState extends State<OtpScreen> {
  @override
  initState() {
    super.initState();
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  void _resendCode() {
    setState(() {
      secondsRemaining = 30;
      enableResend = false;
    });
  }

  @override
  dispose() {
    timer?.cancel();
    super.dispose();
  }

  final ApiServices _apiService = ApiServices();

  final otpController = TextEditingController();
  final PrefService _prefService = PrefService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: textBlack),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: Text(
                'Verify with OTP send to ${widget.mobile}',
                style: GoogleFonts.salsa(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: textBlack),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Pinput(
                controller: otpController,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) => print(pin),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            InkWell(
                onTap: () {
                  if (widget.dropdownValue == "Customer") {
                    _apiService
                        .verifyOtp(
                      widget.mobile,
                      widget.dropdownValue.toLowerCase(),
                      otpController.text.trim(),
                    )
                        .then((value) {
                      log("Otp : ${value}");

                      _prefService.setSelectToken(value["token"]);
                      _prefService.setRegId(value["data"]["_id"]);
                      _prefService.setSelectType(value["data"]["type"]);

                      if (value["message"].toString() == "Login Successfully") {
                        Get.to(() => const NavigationPage());
                      } else if (value["message"].toString() == "Registered Successfully") {
                        Get.to(() => const LocationPage());
                      }  else{
                        log("11111 : $value");
                        Fluttertoast.showToast(msg: value.toString());
                      }
                    });
                  }
                  else if (widget.dropdownValue == 'Partner') {
                    _apiService
                        .verifyOtp(
                      widget.mobile,
                      widget.dropdownValue.toLowerCase(),
                      otpController.text.trim(),
                    )
                        .then((value) {
                      log("message$value");

                      _prefService.setSelectToken(value["token"]);
                      if (value["data"]["shopType"] != null && value["data"]["shopType"] != "") {
                        _prefService.setRegId(value["data"]["_id"]);
                        _prefService.setSelectType(value["data"]["type"]);
                        Get.to(() => const NavigationPage());
                      } else {
                        Get.to(() => VendorRegistration(
                              data: {"mobile": widget.mobile},
                            ));
                      }
                    });
                  }
                  else{
                    Fluttertoast.showToast(msg: "Something went wrong");
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: double.infinity,
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                      color: textBlack,
                      borderRadius: BorderRadius.circular(10)),
                  child: FittedBox(
                    child: Text(
                      'Continue',
                      style: GoogleFonts.alice(
                          color: textWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                )),
            Container(
              padding: const EdgeInsets.only(left: 15, right: 5, top: 10),
              child: Row(
                children: [
                  Text(
                    "Don't receive it?",
                    style: GoogleFonts.alice(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: enableResend ? _resendCode : null,
                    child: Text(
                      " Resend",
                      style: GoogleFonts.alice(
                          fontSize: 18,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    "  00.$secondsRemaining",
                    style: GoogleFonts.alice(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: enableResend ? textBlack : primaryColor,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}