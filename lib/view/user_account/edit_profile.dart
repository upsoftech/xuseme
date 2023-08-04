import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xuseme/constant/image.dart';
import '../../constant/color.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? images;
  final ImagePicker _picker1 = ImagePicker();
  galleryFiles() async {
    var galleryFile = await _picker1.pickImage(source: ImageSource.camera);
    setState(() {
      images = galleryFile as File?;
    });
  }

  File? photo;
  final ImagePicker camera = ImagePicker();
  openGalleryPhoto() async {
    var galleryFile = await camera.pickImage(source: ImageSource.gallery);
    setState(() {
      photo = galleryFile as File?;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
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
          const SizedBox(height: 10,),
          Align(
            alignment: Alignment.center,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
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
                                  galleryFiles();
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
                                  openGalleryPhoto();
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
          Container(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: TextFormField(
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
              keyboardType: TextInputType.phone,
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
                labelText: ('Mobile Number'),
                labelStyle: GoogleFonts.alice(),
                contentPadding: const EdgeInsets.only(top: 10, left: 20),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: TextFormField(
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
