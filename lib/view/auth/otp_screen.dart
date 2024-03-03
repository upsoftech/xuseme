import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:xuseme/view/auth/location.dart';

import '../../constant/color.dart';
import '../../services/api_services.dart';
import '../../services/preference_services.dart';
import '../navigation/navigation_page.dart';
import '../vendor/vandor_registration.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen(
      {Key? key,
      required this.dropdownValue,
      required this.mobile,
      required this.verificationId,
      required this.otp})
      : super(key: key);
  final String dropdownValue;
  final String mobile;
  final String verificationId;
  final String otp;

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
    newVerificationId = widget.verificationId;
  }

  String newVerificationId = "";

  Future<void> _resendCode() async {
    setState(() {
      isLoading = false;

      secondsRemaining = 30;
      enableResend = false;
    });

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91${widget.mobile.trim()}',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          newVerificationId = verificationId;
          otpController.clear();
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  dispose() {
    timer?.cancel();
    super.dispose();
    otpController.clear();
  }

  final ApiServices _apiService = ApiServices();

  FirebaseAuth auth = FirebaseAuth.instance;

  final otpController = TextEditingController();
  final PrefService _prefService = PrefService();

  bool isLoading = false;

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
            Container(
              padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
              child: Pinput(
                length: 6,
                controller: otpController,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) => print(pin),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : InkWell(
                    onTap: () {
                      if (widget.dropdownValue == "Customer") {
                        isLoading = true;
                        setState(() {});
                        // Create a PhoneAuthCredential with the code
                        PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: newVerificationId,
                            smsCode: otpController.text.trim());

                        // Sign the user in (or link) with the credential
                        auth.signInWithCredential(credential).then((value) {
                          log("User : ${value.user}");

                          if (value.user?.phoneNumber ==
                              "+91${widget.mobile}") {
                            _apiService
                                .verifyOtp(
                              widget.mobile,
                              widget.dropdownValue.toLowerCase(),
                              widget.otp,
                            )
                                .then((value) {
                              log("Otp : ${value}");

                              _prefService.setSelectToken(value["token"]);
                              _prefService.setRegId(value["data"]["_id"]);
                              _prefService
                                  .setSelectType(value["data"]["type"]);

                              if (value["message"].toString() ==
                                  "Login Successfully") {
                                Get.to(() => const NavigationPage());
                              } else if (value["message"].toString() ==
                                  "Registered Successfully") {
                                Get.to(() => const LocationPage());
                              } else {
                                log("11111 : $value");
                                Fluttertoast.showToast(msg: value.toString());
                              }
                            });
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            Fluttertoast.showToast(msg: "Incorrect Otp");
                          }
                        }).catchError((err) {
                          print("Error Is : $err");
                          setState(() {
                            isLoading = false;
                          });
                          Fluttertoast.showToast(msg: "Incorrect Otp");
                        });
                      } else if (widget.dropdownValue == 'Partner') {
                        isLoading = true;
                        setState(() {});
                        // Create a PhoneAuthCredential with the code
                        PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: newVerificationId,
                            smsCode: otpController.text.trim());

                        // Sign the user in (or link) with the credential
                        auth.signInWithCredential(credential).then((value) {
                          if (value.user?.phoneNumber ==
                              "+91${widget.mobile}") {
                            _apiService
                                .verifyOtp(
                              widget.mobile,
                              widget.dropdownValue.toLowerCase(),
                              widget.otp,
                            )
                                .then((value) {
                              log("message$value");

                              _prefService.setSelectToken(value["token"]);
                              if (value["data"]["shopType"] != null &&
                                  value["data"]["shopType"] != "") {
                                _prefService.setRegId(value["data"]["_id"]);
                                _prefService
                                    .setSelectType(value["data"]["type"]);
                                Get.to(() => const NavigationPage());
                              } else {
                                Get.to(() => VendorRegistration(
                                  data: {"mobile": widget.mobile},
                                ));
                              }
                            });
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            Fluttertoast.showToast(msg: "Incorrect Otp");
                          }
                        })
                            .catchError((err){
                          print("Error Is : $err");
                          setState(() {
                            isLoading = false;
                          });
                          Fluttertoast.showToast(msg: "Incorrect Otp");
                        });
                      } else {
                        setState(() {
                          isLoading = false;
                        });
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
