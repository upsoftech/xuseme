import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../constant/color.dart';
class BySelf extends StatefulWidget {
  const BySelf({Key? key}) : super(key: key);

  @override
  State<BySelf> createState() => _BySelfState();
}

class _BySelfState extends State<BySelf> {
  String? dropdownValues;
  int selectedMonth=1;

  File? photo;
  final ImagePicker _pick = ImagePicker();
  galleryFile() async {
    var galleryFile = await _pick.pickImage(source: ImageSource.camera);
    setState(() {
      photo = galleryFile as File?;
    });
  }

  File? upload;
  final ImagePicker _uploadImage = ImagePicker();
  uploadPhoto() async {
    var galleryFile = await _uploadImage.pickImage(source: ImageSource.gallery);
    setState(() {
      upload = galleryFile as File?;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        children: [
          Container(
                    padding: const EdgeInsets.fromLTRB(15,20, 15, 0),
                    child: DropdownButtonFormField<String>(
                      key: UniqueKey(),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1,color:textBlack),
                            borderRadius: BorderRadius.circular(5)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1,color:textBlack),
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
                          selectedMonth=int.parse(newStateId);
                        });
                      },
                    ),
                  ),
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
                        galleryFile();
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
                        uploadPhoto();
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
          Text("( 1280 pixels by 720 pixels )",
            style: GoogleFonts.alice(color: location,fontWeight:FontWeight.w400,
                fontSize: 16),),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
            child:Row(
              children: [
                Text("Total Amount",style: GoogleFonts.alice(
                    color: textBlack,fontSize: 16,
                    fontWeight: FontWeight.w600),),
                const SizedBox(width: 15,),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  height: 35,
                  width: 100,
                  decoration: BoxDecoration(
                      color: primary.withOpacity(.1),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child:  Text("₹ ${100*selectedMonth}.00",style: GoogleFonts.alice(
                      color: textBlack,fontSize: 16,
                      fontWeight: FontWeight.w600),),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
