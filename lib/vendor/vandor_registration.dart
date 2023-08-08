import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xuseme/api_services/api_services.dart';
import '../constant/api_constant.dart';
import '../constant/color.dart';
import '../constant/image.dart';
import '../view/screen/navigation_page.dart';
import 'edit_profile.dart';

class VendorRegistration extends StatefulWidget {
  const VendorRegistration({Key? key, this.data}) : super(key: key);
  final Map<String, dynamic>? data;
  @override
  State<VendorRegistration> createState() => _VendorRegistrationState();
}

class _VendorRegistrationState extends State<VendorRegistration> {
  File? image;
  final ImagePicker _picker = ImagePicker();
  galleryFle() async {
    var galleryFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = galleryFile as File?;
    });
  }

  File? photos;
  final ImagePicker camera = ImagePicker();
  openCamera() async {
    var galleryFile = await camera.pickImage(source: ImageSource.camera);
    setState(() {
      photos = galleryFile as File?;
    });
  }

  final pinController = TextEditingController();
  String? dropdownButton;
  String? shopType;

  /// Controller for textfield ///
  final nameController=TextEditingController();
  final mobileController=TextEditingController();
  final landlineController=TextEditingController();
  final emailController=TextEditingController();
  final shopNameController=TextEditingController();
  final shopTypeController=TextEditingController();
  final addressController=TextEditingController();
  final landmarkController=TextEditingController();
  final stateController=TextEditingController();
  final addServicesController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: btnColor,
        elevation: 0,
        title: Text("Registration",style: GoogleFonts.alice(color: textWhite,fontWeight: FontWeight.bold,fontSize: 16),),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       Get.to(const EditVendorProfile());
        //     },
        //     icon: const Icon(
        //       Icons.edit,
        //       color: textWhite,
        //     ),
        //   ),
        // ],
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          ApiServices().registerProfile({
            "name":nameController.text.trim(),
            "mobile":mobileController.text.trim(),
            "landline":landlineController.text.trim(),
            "email":emailController.text.trim(),
            "shopName":shopNameController.text.trim(),
            "address": addressController.text.trim(),
            "landmark":landmarkController.text.trim(),
            "pincode":pinController.text.trim(),
            "services":addServicesController.text.trim(),
            "shopType":shopType,
            "state":dropdownButton,
            "type":"partner"
          }).then((value){
            Fluttertoast.showToast(msg: "$value",backgroundColor: btnColor);
          });

          // _prefService.setRegId(value["data"]["_id"]);
          // Get.to(const NavigationPage());
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
                      borderSide: const BorderSide(width: 1, color: textBlack),
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: textBlack),
                      borderRadius: BorderRadius.circular(10)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: ('Name'),
                  labelStyle: GoogleFonts.alice(),
                  contentPadding: const EdgeInsets.only(top: 10, left: 20),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: TextFormField(
                controller: mobileController,
                cursorColor: Colors.black,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: textBlack),
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: textBlack),
                      borderRadius: BorderRadius.circular(10)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: ('Mobile No.'),
                  labelStyle: GoogleFonts.alice(),
                  contentPadding: const EdgeInsets.only(top: 10, left: 20),
                ),
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
                      borderSide: const BorderSide(width: 1, color: textBlack),
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: textBlack),
                      borderRadius: BorderRadius.circular(10)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: ('Landline No.'),
                  labelStyle: GoogleFonts.alice(),
                  contentPadding: const EdgeInsets.only(top: 10, left: 20),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: TextFormField(
                controller: emailController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: textBlack),
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: textBlack),
                      borderRadius: BorderRadius.circular(10)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: ('Email'),
                  labelStyle: GoogleFonts.alice(),
                  contentPadding: const EdgeInsets.only(top: 10, left: 20),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: TextFormField(
                controller: shopNameController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: textBlack),
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: textBlack),
                      borderRadius: BorderRadius.circular(10)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: ('Shop name'),
                  labelStyle: GoogleFonts.alice(),
                  contentPadding: const EdgeInsets.only(top: 10, left: 20),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: DropdownButtonFormField<String>(

                key: UniqueKey(),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: textBlack),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: textBlack),
                      borderRadius: BorderRadius.circular(10)),
                  labelText: 'Shop Type ',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  labelStyle: GoogleFonts.alice(),
                ),
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
                      borderSide: const BorderSide(width: 1, color: textBlack),
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: textBlack),
                      borderRadius: BorderRadius.circular(10)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: ('Address'),
                  labelStyle: GoogleFonts.alice(),
                  contentPadding: const EdgeInsets.only(top: 10, left: 20),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: TextFormField(
                controller: landmarkController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: textBlack),
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: textBlack),
                      borderRadius: BorderRadius.circular(10)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: ('Landmark'),
                  labelStyle: GoogleFonts.alice(),
                  contentPadding: const EdgeInsets.only(top: 10, left: 20),
                ),
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
                              borderSide:
                                  const BorderSide(width: 1, color: textBlack),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(width: 1, color: textBlack),
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'State',
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          labelStyle: GoogleFonts.alice()),
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
                      borderSide: const BorderSide(width: 1, color: textBlack),
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: textBlack),
                      borderRadius: BorderRadius.circular(10)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: ('Add Services'),
                  labelStyle: GoogleFonts.alice(),
                  contentPadding: const EdgeInsets.only(top: 10, left: 20),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                                    openCamera();
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
                                    galleryFle();
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
      )),
    );
  }
}
