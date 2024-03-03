import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xuseme/constant/image.dart';
import 'package:xuseme/view/auth/otp_screen.dart';

import '../../constant/color.dart';
import '../../services/api_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final mobileNumber = TextEditingController();
  String? dropdownValue;
  final ApiServices _apiService = ApiServices();

  bool valuefirst = false;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    // isLoading = false;
    // setState(() {});
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, textWhite],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: textBlack),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 71,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage(splashImages),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .1,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: DropdownButtonFormField<String>(
                  key: UniqueKey(),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: textBlack),
                        borderRadius: BorderRadius.circular(5)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: textBlack),
                        borderRadius: BorderRadius.circular(5)),
                    hintText: 'Select Type',
                    contentPadding: const EdgeInsets.only(left: 10, right: 10),
                    suffixStyle: const TextStyle(
                        color: textBlack, fontWeight: FontWeight.bold),
                  ),
                  value: dropdownValue,
                  items: const [
                    DropdownMenuItem<String>(
                      value: "Customer",
                      child: Text("Customer"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Partner",
                      child: Text("Partner"),
                    ),
                  ],
                  onChanged: (String? newStateId) {
                    setState(() {
                      dropdownValue = newStateId!;
                      log("check$dropdownValue");
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  'Enter Your Mobile Number',
                  style: GoogleFonts.salsa(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: textBlack),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: TextFormField(
                  controller: mobileNumber,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10)
                  ],
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: textBlack)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: textBlack)),
                    labelText: ('Phone Number'),
                    labelStyle: GoogleFonts.alice(
                        color: textBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    contentPadding: const EdgeInsets.only(left: 20, top: 10),
                    border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: textBlack),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onChanged: (phone) {
                    // print(phone.completeNumber);
                  },
                  // onCountryChanged: (country) {
                  //   // print('Country changed to: ' + country.name);
                  // },
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
                      onTap: () async {
                        if (mobileNumber.text.trim() != "" &&
                            mobileNumber.text.trim().length == 10 &&
                            dropdownValue!.toLowerCase() == "customer" &&
                            valuefirst == true) {
                          isLoading = true;
                          setState(() {});

                          _apiService
                              .logInMobile(mobileNumber.text.trim(),
                                  dropdownValue!.toLowerCase())
                              .then((value) async {
                            log("LOGIN_SCREEN : ${value}");
                            log("LOGIN_SCREEN $dropdownValue");
                            if (value["status"] != "0" &&
                                value["otp"] != null) {
                              // Fluttertoast.showToast(
                              //     msg: "OTP Is ${value["otp"]}");

                              await FirebaseAuth.instance.verifyPhoneNumber(
                                phoneNumber: '+91${mobileNumber.text.trim()}',
                                verificationCompleted:
                                    (PhoneAuthCredential credential) {},
                                verificationFailed:
                                    (FirebaseAuthException e) {},
                                codeSent:
                                    (String verificationId, int? resendToken) {
                                  Get.to(() => OtpScreen(
                                        dropdownValue: 'Customer',
                                        mobile: mobileNumber.text.trim(),
                                        verificationId: verificationId,
                                        otp: value["otp"].toString(),
                                      ));
                                },
                                codeAutoRetrievalTimeout:
                                    (String verificationId) {},
                              );
                            } else if (value["message"]
                                .toString()
                                .contains("Number already exists")) {
                              isLoading = false;
                              setState(() {});
                              Fluttertoast.showToast(
                                  msg: "Number already register as partner");
                            } else {
                              // Fluttertoast.showToast(msg: "");
                              isLoading = false;
                              setState(() {});
                            }
                          });
                        } else if (mobileNumber.text.trim() != "" &&
                            mobileNumber.text.trim().length == 10 &&
                            dropdownValue!.toLowerCase() == "partner" &&
                            valuefirst == true) {
                          isLoading = true;
                          setState(() {});

                          _apiService
                              .logInMobile(mobileNumber.text.trim(),
                                  dropdownValue!.toLowerCase())
                              .then((value) async {
                            if (value["status"] != "0" &&
                                value["otp"] != null) {
                              // Fluttertoast.showToast(
                              //     msg: "OTP Is ${value["otp"]}");
                              await FirebaseAuth.instance.verifyPhoneNumber(
                                phoneNumber: '+91${mobileNumber.text.trim()}',
                                verificationCompleted:
                                    (PhoneAuthCredential credential) {},
                                verificationFailed:
                                    (FirebaseAuthException e) {},
                                codeSent:
                                    (String verificationId, int? resendToken) {
                                  Get.to(() => OtpScreen(
                                        dropdownValue: 'Partner',
                                        mobile: mobileNumber.text.trim(),
                                        verificationId: verificationId,
                                        otp: value["otp"].toString(),
                                      ));
                                },
                                codeAutoRetrievalTimeout:
                                    (String verificationId) {},
                              );
                            } else if (value["message"]
                                .toString()
                                .contains("Number already exists")) {
                              Fluttertoast.showToast(
                                  msg: "Number already register as user");
                              isLoading = false;
                              setState(() {});
                            } else {
                              // Fluttertoast.showToast(msg: "${value}");
                              isLoading = false;
                              setState(() {});
                            }
                          });
                        } else if (mobileNumber.text.trim().length < 10) {
                          Fluttertoast.showToast(
                            msg: 'Enter valid mobile number',
                            backgroundColor: primaryColor,
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: 'Please Select Required ',
                            backgroundColor: primaryColor,
                          );
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
                        child: Text(
                          'Login With OTP',
                          style: GoogleFonts.alice(
                              color: textWhite,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      )),
              Container(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 15),
                child: Row(
                  children: [
                    Checkbox(
                      checkColor: textWhite,
                      activeColor: primaryColor,
                      value: valuefirst,
                      onChanged: (bool? value) {
                        setState(() {
                          valuefirst = value!;
                        });
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .74,
                      child: Text.rich(TextSpan(
                          text: 'By clicking , I accept the  ',
                          style: GoogleFonts.alice(fontSize: 16),
                          children: <InlineSpan>[
                            TextSpan(
                              text: 'term of service ',
                              style: GoogleFonts.alice(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  color: primaryColor),
                            ),
                            TextSpan(
                                text: ' and ',
                                style: GoogleFonts.alice(fontSize: 16)),
                            TextSpan(
                              text: 'privacy policy.',
                              style: GoogleFonts.alice(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  color: primaryColor),
                            )
                          ])),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
