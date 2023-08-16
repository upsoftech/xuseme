import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xuseme/api_services/api_services.dart';
import '../api_services/preference_services.dart';
import '../constant/api_constant.dart';
import '../constant/color.dart';
import '../constant/image.dart';
import '../view/screen/navigation_page.dart';
import 'edit_vndor_profile.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class VendorRegistration extends StatefulWidget {
  const VendorRegistration({Key? key, this.data}) : super(key: key);
  final Map<String, dynamic>? data;
  @override
  State<VendorRegistration> createState() => _VendorRegistrationState();
}

class _VendorRegistrationState extends State<VendorRegistration> {


  XFile? images;
  final ImagePicker _picker = ImagePicker();

  openPhoto(ImageSource imageSource) async {
    await _picker.pickImage(source: imageSource).then((value) {
      images = value;
      setState(() {});
      Navigator.pop(context);
    });
  }

  final pinController = TextEditingController();
  String? dropdownButton;
  String? shopType;

  /// Controller for textfield ///
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final landlineController = TextEditingController();
  final emailController = TextEditingController();
  final shopNameController = TextEditingController();
  final shopTypeController = TextEditingController();
  final addressController = TextEditingController();
  final landmarkController = TextEditingController();
  final stateController = TextEditingController();
  final addServicesController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mobileController.text = widget.data!["mobile"];
  }

  void signup(String name, mobile, landline, email,
      shopName, shopType, address,
      landmark, pincode, state, addServices,
      {required String  partner}) async {
    try {
      var tokenIds = PrefService().getToken();
      var response =
          await post(Uri.parse(ApiConstant.vendorRegistration), body: {
        "name": name,
        "mobile": mobile,
        "landline": landline,
        "email": email,
        "shopName": shopName,
        "address": address,
        "landmark": landmark,
        "pincode": pincode,
        "services": addServices,
        "shopType": shopType,
        "state": state,
        "type": "partner"
      },
            headers: {
            'Authorization': 'Bearer $tokenIds',
            },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        if (kDebugMode) {
          print(data['token']);
        }
        log("message:$response");
        log("message:${response.body}");
        if (kDebugMode) {
          print('Signup successfully');
        }
      } else {
        if (kDebugMode) {
          print('Signup failed');
        }
      }
    } catch (e) {
      if (kDebugMode) {
          print(e.toString());
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: btnColor,
        elevation: 0,
        title: Text(
          "Registration",
          style: GoogleFonts.alice(
              color: textWhite, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if (formKey.currentState!.validate()) {
            // ApiServices().registerProfile({
            //   "name":nameController.text.trim(),
            //   "mobile":mobileController.text.trim(),
            //   "landline":landlineController.text.trim(),
            //   "email":emailController.text.trim(),
            //   "shopName":shopNameController.text.trim(),
            //   "address": addressController.text.trim(),
            //   "landmark":landmarkController.text.trim(),
            //   "pincode":pinController.text.trim(),
            //   "services":addServicesController.text.trim(),
            //   "shopType":shopType,
            //   "state":dropdownButton,
            //   "type":"partner"
            // }).then((value){
            //
            //   log("value$value");
            //   PrefService().setRegId(value["data"]["_id"]);
            //
            //   Fluttertoast.showToast(msg: "$value",backgroundColor: btnColor);
            // });

            // _prefService.setRegId(value["data"]["_id"]);
            // Get.to(const NavigationPage());
            // log("message1111$shopType");

            signup(
                nameController.text.toString().trim(),
                mobileController.text.toString().trim(),
                landlineController.text.toString().trim(),
                emailController.text.toString().trim(),
                shopNameController.text.toString().trim(),
                addressController.text.toString().trim(),
                landmarkController.text.toString().trim(),
                pinController.text.toString().trim(),
                addServicesController.text.toString().trim(),
                shopType,
                dropdownButton,
                partner: 'partner'
            );

          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          alignment: Alignment.center,
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
              color: textBlack, borderRadius: BorderRadius.circular(15)),
          child: Text(
            "Continue",
            style: GoogleFonts.alice(
                color: textWhite, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: TextFormField(
                  controller: nameController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: textBlack),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: textBlack),
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: ('Name'),
                    labelStyle: GoogleFonts.alice(),
                    contentPadding: const EdgeInsets.only(top: 10, left: 20),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'name is required';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: TextFormField(
                  controller: mobileController,
                  cursorColor: Colors.black,
                  readOnly: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: textBlack),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: textBlack),
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: ('Mobile No.'),
                    labelStyle: GoogleFonts.alice(),
                    contentPadding: const EdgeInsets.only(top: 10, left: 20),
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                            .hasMatch(value)) {
                      return "Enter Mobile Number";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: TextFormField(
                  controller: landlineController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: textBlack),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: textBlack),
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: ('Landline No.'),
                    labelStyle: GoogleFonts.alice(),
                    contentPadding: const EdgeInsets.only(top: 10, left: 20),
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                            .hasMatch(value)) {
                      return "Enter Landline Number";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: TextFormField(
                  controller: emailController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: textBlack),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: textBlack),
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: ('Email'),
                    labelStyle: GoogleFonts.alice(),
                    contentPadding: const EdgeInsets.only(top: 10, left: 20),
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                      return "Enter valid Email";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: TextFormField(
                  controller: shopNameController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: textBlack),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: textBlack),
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: ('Shop name'),
                    labelStyle: GoogleFonts.alice(),
                    contentPadding: const EdgeInsets.only(top: 10, left: 20),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Shop name is required';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: DropdownButtonFormField<String>(
                  key: UniqueKey(),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: textBlack),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: textBlack),
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Shop Type ',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    labelStyle: GoogleFonts.alice(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Shop Type is required';
                    }
                    return null;
                  },
                  value: shopType,
                  items: const [
                    DropdownMenuItem<String>(
                      value: "Cake shop",
                      child: Text("Cake shop"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Mobile Center",
                      child: Text("Mobile Center"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Pet Shop",
                      child: Text("Pet Shop"),
                    ),
                  ],
                  onChanged: (String? newStateId) {
                    setState(() {
                      shopType = newStateId!;
                    });
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: TextFormField(
                  controller: addressController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: textBlack),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: textBlack),
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: ('Address'),
                    labelStyle: GoogleFonts.alice(),
                    contentPadding: const EdgeInsets.only(top: 10, left: 20),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Address is required';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: TextFormField(
                  controller: landmarkController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: textBlack),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: textBlack),
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: ('Landmark'),
                    labelStyle: GoogleFonts.alice(),
                    contentPadding: const EdgeInsets.only(top: 10, left: 20),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Landmark is required';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: TextFormField(
                        controller: pinController,
                        onChanged: (v) {
                          if (v.length >= 7) {
                            pinController.text = "";
                            Fluttertoast.showToast(
                                msg: "Only Required 6 digit",
                                backgroundColor: btnColor);
                          }
                        },
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(width: 1, color: textBlack),
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(width: 1, color: textBlack),
                              borderRadius: BorderRadius.circular(10)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: ('Pin Code'),
                          labelStyle: GoogleFonts.alice(),
                          contentPadding:
                              const EdgeInsets.only(top: 10, left: 20),
                        ),
                        // validator: (value) {
                        //   if (value!.isEmpty ||
                        //       !RegExp(r'^[1-9]{1}[0-9]{2}\\s{0,1}[0-9]{3}$')
                        //           .hasMatch(value)) {
                        //     return "Enter Pin Code";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        key: UniqueKey(),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: textBlack),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: textBlack),
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'State',
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            labelStyle: GoogleFonts.alice()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select state';
                          }
                          return null;
                        },
                        value: dropdownButton,
                        items: const [
                          DropdownMenuItem<String>(
                            value: "Andhra Pradesh",
                            child: Text("Andhra Pradesh"),
                          ),
                          DropdownMenuItem<String>(
                            value: "Arunachal Pradesh",
                            child: Text("Arunachal Pradesh"),
                          ),
                          DropdownMenuItem<String>(
                            value: "Assam",
                            child: Text("Assam"),
                          ),
                          DropdownMenuItem<String>(
                            value: "Bihar",
                            child: Text("Bihar"),
                          ),
                          DropdownMenuItem<String>(
                            value: "Chhattisgarh",
                            child: Text("Chhattisgarh"),
                          ),
                          DropdownMenuItem<String>(
                            value: "Goa",
                            child: Text("Goa"),
                          ),
                          DropdownMenuItem<String>(
                            value: "Gujarat",
                            child: Text("Gujarat"),
                          ),
                          DropdownMenuItem<String>(
                            value: "Haryana",
                            child: Text("Haryana"),
                          ),
                          DropdownMenuItem<String>(
                            value: "Himachal Pradesh",
                            child: Text("Himachal Pradesh"),
                          ),
                          DropdownMenuItem<String>(
                            value: "Jharkhand",
                            child: Text("Jharkhand"),
                          ),
                          DropdownMenuItem<String>(
                            value: "Karnataka",
                            child: Text("Karnataka"),
                          ),
                          DropdownMenuItem<String>(
                            value: "Kerala",
                            child: Text("Kerala"),
                          ),
                          DropdownMenuItem<String>(
                            value: "Madhya Pradesh",
                            child: Text("Madhya Pradesh"),
                          ),
                          DropdownMenuItem<String>(
                            value: "Maharashtra",
                            child: Text("Maharashtra"),
                          ),
                          DropdownMenuItem<String>(
                            value: "Manipur",
                            child: Text("Manipur"),
                          ),
                          DropdownMenuItem<String>(
                            value: "Meghalaya",
                            child: Text("Meghalaya"),
                          ),
                          DropdownMenuItem<String>(
                            value: "Mizoram",
                            child: Text("Mizoram"),
                          ),
                          DropdownMenuItem<String>(
                            value: "New Delhi",
                            child: Text("New Delhi"),
                          ),
                          DropdownMenuItem<String>(
                            value: "Nagaland",
                            child: Text("Nagaland"),
                          ),
                          DropdownMenuItem<String>(
                            value: "Odisha",
                            child: Text("Odisha"),
                          ),
                          DropdownMenuItem<String>(
                            value: "Punjab",
                            child: Text("Punjab"),
                          ),
                          DropdownMenuItem<String>(
                            value: "Rajasthan",
                            child: Text("Rajasthan"),
                          ),
                          DropdownMenuItem<String>(
                            value: "Sikkim",
                            child: Text("Sikkim"),
                          ),
                          DropdownMenuItem<String>(
                            value: "Tamil Nadu",
                            child: Text("Tamil Nadu"),
                          ),
                          DropdownMenuItem<String>(
                            value: "Telangana",
                            child: Text("Telangana"),
                          ),
                          DropdownMenuItem<String>(
                            value: "Tripura",
                            child: Text("Tripura"),
                          ),
                          DropdownMenuItem<String>(
                            value: "Uttar Pradesh",
                            child: Text("Uttar Pradesh"),
                          ),
                          DropdownMenuItem<String>(
                            value: "Uttarakhand",
                            child: Text("Uttarakhand"),
                          ),
                          DropdownMenuItem<String>(
                            value: "West Bengal",
                            child: Text("West Bengal"),
                          ),
                        ],
                        onChanged: (String? newStateId) {
                          setState(() {
                            dropdownButton = newStateId!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: TextFormField(
                  controller: addServicesController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: textBlack),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: textBlack),
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: ('Add Services'),
                    labelStyle: GoogleFonts.alice(),
                    contentPadding: const EdgeInsets.only(top: 10, left: 20),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Add Services';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  "Upload Shop Logo",
                  style: GoogleFonts.alice(
                      color: textBlack,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.withOpacity(.2),
                      // backgroundImage: NetworkImage(
                      //   widget.data!["shopLogo"].toString() != ""
                      //       ? "${ApiConstant.baseUrl}/${widget.data!["shopLogo"]}"
                      //       : noImage,
                      // ),
                    ),
                    Positioned(
                      bottom: -10,
                      child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                content: TextButton(
                                    onPressed: () {
                                      openPhoto(ImageSource.camera);
                                    },
                                    child: Text(
                                      "From Camera",
                                      style: GoogleFonts.alice(
                                          color: Colors.blue,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )),
                                title: TextButton(
                                    onPressed: () {
                                      openPhoto(ImageSource.gallery);
                                    },
                                    child: Text(
                                      "From Gallery",
                                      style: GoogleFonts.alice(
                                          color: Colors.blue,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.camera_alt,
                            color: btnColor,
                            size: 30,
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
