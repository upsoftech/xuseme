import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../constant/color.dart';
class PublishedOffer extends StatefulWidget {
  const PublishedOffer({Key? key}) : super(key: key);

  @override
  State<PublishedOffer> createState() => _PublishedOfferState();
}

class _PublishedOfferState extends State<PublishedOffer> {
  File? offer;
  final ImagePicker _picker = ImagePicker();
  offerGallery() async {
    var galleryFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      offer = galleryFile as File?;
    });
  }

  File? choose;
  final ImagePicker camera = ImagePicker();
  chooseCamera() async {
    var galleryFile = await camera.pickImage(source: ImageSource.camera);
    setState(() {
      choose = galleryFile as File?;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: btnColor,
        elevation: 0,
        title: Text("Published Offer",style: GoogleFonts.alice(color: textWhite,fontWeight: FontWeight.bold,fontSize: 16),),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          alignment: Alignment.center,
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
              color: textBlack, borderRadius: BorderRadius.circular(15)),
          child: Text(
            " Publish Offer",
            style: GoogleFonts.alice(
                color: textWhite, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
              height: MediaQuery.of(context).size.height*.25,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color:textBlack),
                  borderRadius: BorderRadius.circular(10)
              ),
              child:TextButton(onPressed:(){
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    content: TextButton(
                        onPressed: () {
                          chooseCamera();
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
                          offerGallery();
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
                  child: Text("Choose Photo",style: GoogleFonts.alice(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.bold),)),

            ),
            // Container(
            //   padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            //   child: TextFormField(
            //     cursorColor: Colors.black,
            //     decoration: InputDecoration(
            //       focusedBorder: OutlineInputBorder(
            //           borderSide: const BorderSide(width: 1, color: textBlack),
            //           borderRadius: BorderRadius.circular(10)),
            //       enabledBorder: OutlineInputBorder(
            //           borderSide: const BorderSide(width: 1, color: textBlack),
            //           borderRadius: BorderRadius.circular(10)),
            //       border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(10)),
            //       labelText: ('Write Offer(optional)'),
            //       labelStyle: GoogleFonts.alice(),
            //       contentPadding: const EdgeInsets.only(top: 10, left: 20),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
