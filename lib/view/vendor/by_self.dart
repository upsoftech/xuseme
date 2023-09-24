import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xuseme/services/preference_services.dart';

import '../../services/api_services.dart';
import '../../constant/color.dart';

class BySelf extends StatefulWidget {
  const BySelf({Key? key}) : super(key: key);

  @override
  State<BySelf> createState() => _BySelfState();
}

class _BySelfState extends State<BySelf> {
  String? dropdownValues;
  int selectedMonth = 1;

  XFile? upload;
  final ImagePicker _uploadImage = ImagePicker();

  uploadPhoto(ImageSource imageSource) async {
    await _uploadImage.pickImage(source: imageSource).then((value) {
      upload = value;
      setState(() {});
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if (upload?.path != null) {
            ApiServices()
                .addBannerBySelf(PrefService().getRegId(), dropdownValues,
                    upload!.path, "${100 * selectedMonth}")
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
            "Pay",
            style: GoogleFonts.alice(
                color: textWhite, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: DropdownButtonFormField<String>(
              key: UniqueKey(),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: textBlack),
                    borderRadius: BorderRadius.circular(5)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: textBlack),
                    borderRadius: BorderRadius.circular(5)),
                hintText: 'Select Month',
                contentPadding: const EdgeInsets.only(left: 10, right: 10),
                suffixStyle: const TextStyle(
                    color: textBlack, fontWeight: FontWeight.bold),
              ),
              value: dropdownValues,
              items: const [
                DropdownMenuItem<String>(
                  value: "1",
                  child: Text("One Month"),
                ),
                DropdownMenuItem<String>(
                  value: "2",
                  child: Text("Two Month"),
                ),
                DropdownMenuItem<String>(
                  value: "3",
                  child: Text("Three Month"),
                ),
                DropdownMenuItem<String>(
                  value: "4",
                  child: Text("Four Month"),
                ),
                DropdownMenuItem<String>(
                  value: "5",
                  child: Text("Five Month"),
                ),
                DropdownMenuItem<String>(
                  value: "6",
                  child: Text("Six Month"),
                ),
                DropdownMenuItem<String>(
                  value: "7",
                  child: Text("Seven Month"),
                ),
                DropdownMenuItem<String>(
                  value: "8",
                  child: Text("Eight Month"),
                ),
                DropdownMenuItem<String>(
                  value: "9",
                  child: Text("Nine Month"),
                ),
                DropdownMenuItem<String>(
                  value: "10",
                  child: Text("Ten Month"),
                ),
                DropdownMenuItem<String>(
                  value: "11",
                  child: Text("Eleven Month"),
                ),
                DropdownMenuItem<String>(
                  value: "12",
                  child: Text("Twelve Month"),
                ),
              ],
              onChanged: (String? newStateId) {
                setState(() {
                  dropdownValues = newStateId!;
                  selectedMonth = int.parse(newStateId);
                });
              },
            ),
          ),
          upload == null
              ? Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  height: MediaQuery.of(context).size.height * .25,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: textBlack),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            content: TextButton(
                                onPressed: () {
                                  uploadPhoto(ImageSource.camera);
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
                                  uploadPhoto(ImageSource.gallery);
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
                      child: Text(
                        "Choose Photo",
                        style: GoogleFonts.alice(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )),
                )
              : Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  height: MediaQuery.of(context).size.height * .25,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(File(upload!.path)))),
                ),
          Text(
            "( 1280 pixels by 720 pixels )",
            style: GoogleFonts.alice(
                color: red, fontWeight: FontWeight.w400, fontSize: 16),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Row(
              children: [
                Text(
                  "Total Amount",
                  style: GoogleFonts.alice(
                      color: textBlack,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 15,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  height: 35,
                  width: 100,
                  decoration: BoxDecoration(
                      color: primary.withOpacity(.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "₹ ${100 * selectedMonth}.00",
                    style: GoogleFonts.alice(
                        color: textBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
