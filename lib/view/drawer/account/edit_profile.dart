import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:xuseme/services/api_services.dart';
import 'package:xuseme/constant/image.dart';
import 'package:xuseme/provider/location_provider.dart';
import '../../../constant/color.dart';
import '../../../provider/profile_provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key, required this.data}) : super(key: key);
  final Map<String, dynamic> data;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.data["name"] ?? "";
    mobileController.text = widget.data["mobile"] ?? "";
    emailController.text = widget.data["email"] ?? "";
  }

  XFile? photo;
  final ImagePicker camera = ImagePicker();

  openGalleryPhoto(ImageSource imageSource) async {
    await camera.pickImage(source: imageSource).then((value) {
      photo = value;
      setState(() {});
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);

    log("message${locationProvider.locationData!.latitude}");
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          ApiServices()
              .updateUserProfile(
            nameController.text.trim(),
            emailController.text.trim(),
            photo?.path,
            locationProvider.locationData!.latitude,
            locationProvider.locationData!.longitude,
          )
              .then((value) {
            Fluttertoast.showToast(msg: "${value["message"]}");
            Get.back();
            Provider.of<ProfileProvider>(context, listen: false).getProfile();
          });
        },
        child: Container(
          alignment: Alignment.center,
          height: 45,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: textBlack, borderRadius: BorderRadius.circular(10)),
          child: Text(
            'Submit',
            style: GoogleFonts.salsa(fontSize: 16, color: textWhite),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: GoogleFonts.alice(color: textBlack, fontSize: 16),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: textBlack),
        elevation: 0,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.center,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                photo != null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.withOpacity(.2),
                        backgroundImage: FileImage(File(photo!.path)),
                      )
                    : CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.withOpacity(.2),
                        backgroundImage: const AssetImage(window),
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
                                  openGalleryPhoto(ImageSource.camera);
                                },
                                child: Text(
                                  "From Camera",
                                  style: GoogleFonts.alice(
                                      color: textBlack,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                            title: TextButton(
                                onPressed: () {
                                  openGalleryPhoto(ImageSource.gallery);
                                },
                                child: Text(
                                  "From Gallery",
                                  style: GoogleFonts.alice(
                                      color: textBlack,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.camera_alt,
                        color: primaryColor,
                        size: 30,
                      )),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
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
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
              keyboardType: TextInputType.phone,
              cursorColor: Colors.black,
              readOnly: true,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: textBlack),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: textBlack),
                    borderRadius: BorderRadius.circular(10)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: ('Mobile Number'),
                labelStyle: GoogleFonts.alice(),
                contentPadding: const EdgeInsets.only(top: 10, left: 20),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: textBlack),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: textBlack),
                    borderRadius: BorderRadius.circular(10)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: ('Enter Email'),
                labelStyle: GoogleFonts.alice(),
                contentPadding: const EdgeInsets.only(top: 10, left: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
