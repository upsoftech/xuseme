import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../constant/app_constants.dart';
import '../../constant/color.dart';
import '../../constant/image.dart';
import 'category_details.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
class CategoryList extends StatefulWidget {
  const CategoryList({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {

  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _textSpeech = 'Hello';
  List name = [
    "Aggarwal Sweet", "Mirthless AC repair", "Mobile Center", "Aggarwal Hotel",
    "Pankaj Ro", "Mirthless AC repair", "Mobile Center", "Aggarwal Hotel", "Pankaj Ro",
  ];
  List subTitle = [
    "Snacks,Indian", "AC repair", "Moto Mobile", "VIP Hotel", "Water", "Snacks,Indian",
    "AC repair", "Moto Mobile", "VIP Hotel",
  ];
  List image = [
    banner, acAir, window, hotel, ro, banner, services, window, hotel,
  ];
  TextEditingController searchController = TextEditingController();
  void onListen() async {
    bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'));

    if (!_isListening) {
      if (available) {
        setState(() {
          _isListening = false;
          _speech.listen(
            onResult: (val) => setState(() {
              _textSpeech = val.recognizedWords;
              searchController.text = val.recognizedWords;
            }),
          );
        });
      }
    } else {
      setState(() {
        _isListening = false;
        _speech.stop();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, position) {
        return GestureDetector(
          onTap:(){
            Get.to(const CategoryDetailsList());
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      border: Border.all(color: grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset(image[position],
                      height: 20,width:20),
                ),
                const SizedBox(width: 10,),
                SizedBox(
                  width: MediaQuery.of(context).size.width*.72,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name[position],
                        style: GoogleFonts.alice(
                            color: textBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Text(
                        subTitle[position],
                        style: GoogleFonts.alice(fontSize: 16),
                      ),
                      Text(
                        "Starting ₹120",
                        style: GoogleFonts.alice(fontSize: 16),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, position) {
        return const Divider(
          color: grey,
        );
      },
      itemCount: name.length,
    );
  }
}
