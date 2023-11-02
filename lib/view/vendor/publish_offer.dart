import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/api_services.dart';
import '../../services/preference_services.dart';
import '../../constant/color.dart';


class PublishedOffer extends StatefulWidget {
  const PublishedOffer({Key? key}) : super(key: key);

  @override
  State<PublishedOffer> createState() => _PublishedOfferState();
}

class _PublishedOfferState extends State<PublishedOffer> {
  XFile? offerImg;
  final ImagePicker _picker = ImagePicker();

  selectImage(ImageSource source) async {
    await _picker.pickImage(source: source).then((value) {
      offerImg = value;
      setState(() {});
      Navigator.pop(context);
    });
  }

  final offerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Publish your Offer",
          style: GoogleFonts.alice(
              color: textWhite, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if (offerImg?.path != null) {
            ApiServices()
                .publishOffer(PrefService().getRegId(), offerImg!.path,
                    offerController.text.trim())
                .then((value) {
              Fluttertoast.showToast(
                  msg: "${value["message"]}", backgroundColor: primaryColor);
            });
            Navigator.pop(context);
          } else {
            Fluttertoast.showToast(msg: "Please Select Banner ");
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
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              height: MediaQuery.of(context).size.height * .25,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: offerImg?.path != null
                      ? DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(File(offerImg!.path)))
                      : DecorationImage(
                          image: NetworkImage(
                              "https://wallpapers.com/images/featured/blank-white-7sn5o1woonmklx1h.jpg")),
                  border: Border.all(color: textBlack),
                  borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        content: TextButton(
                            onPressed: () {
                              selectImage(ImageSource.camera);
                            },
                            child: Text(
                              "From Camera",
                              style: GoogleFonts.alice(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                        title: TextButton(
                            onPressed: () {
                              selectImage(ImageSource.gallery);
                            },
                            child: Text(
                              "From Gallery",
                              style: GoogleFonts.alice(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    );
                  },
                  child: Text(
                    "Choose Photo",
                    style: GoogleFonts.alice(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: TextFormField(
                controller: offerController,
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
                  labelText: ('Write Offer(optional)'),
                  labelStyle: GoogleFonts.alice(),
                  contentPadding: const EdgeInsets.only(top: 10, left: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
