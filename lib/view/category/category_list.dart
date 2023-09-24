import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:xuseme/constant/color.dart';

import '../../constant/app_constants.dart';
import '../../provider/category_provider.dart';
import '../../provider/location_provider.dart';
import 'category_details.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key, this.type, this.isPremium}) : super(key: key);

  final String? type;
  final bool? isPremium;

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  late CategoryProvider categoryProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    categoryProvider.getCategoryData(
        query: '', isPremium: widget.isPremium );
    _initSpeech();
  }

  final searchTextController = TextEditingController();

  final SpeechToText _speechToText = SpeechToText();

  bool _speechEnabled = false;

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
    if (!_speechEnabled) {
      log("message11");
    }
  }

  void _startListening() async {
    try {
      await _speechToText.listen(onResult: _onSpeechResult);
    } catch (e) {
      print(e);
      log("message11${e}");
    }
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    searchTextController.text = result.recognizedWords;
    categoryProvider.getCategoryData(query: result.recognizedWords);
    log("message11${result.recognizedWords}");
  }

  @override
  Widget build(BuildContext context) {
    categoryProvider = Provider.of<CategoryProvider>(context);
    final locationProvider = Provider.of<LocationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: TextFormField(
            cursorColor: textWhite,
            controller: searchTextController,
            style: const TextStyle(color: textWhite),
            onChanged: (v) {
              categoryProvider.getCategoryData(
                  query: v, isPremium: widget.isPremium );
            },
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: textWhite),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: textWhite),
                    borderRadius: BorderRadius.circular(10)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: ('Search here '),
                labelStyle: GoogleFonts.alice(color: textWhite),
                contentPadding: const EdgeInsets.only(top: 10, left: 20),
                suffixIcon: SizedBox(
                  width: AppConstant.width(context) * 0.3,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            categoryProvider.getCategoryData(
                                query: searchTextController.text,
                                isPremium: widget.isPremium );
                          },
                          icon: const Icon(
                            Icons.search,
                            color: textWhite,
                          )),
                      const Text('|'),
                      IconButton(
                          onPressed: _speechToText.isNotListening
                              ? _startListening
                              : _stopListening,
                          icon: Icon(
                            _speechToText.isNotListening
                                ? Icons.mic_off
                                : Icons.mic,
                            color: textWhite,
                          ))
                    ],
                  ),
                )),
          ),
        ),
      ),
      body: Center(
          child: categoryProvider.isLoading
              ? const CircularProgressIndicator(
                  color: primaryColor,
                )
              : categoryProvider.categoryList.isEmpty
                  ? Center(
                      child: Text(
                        "No Data Found",
                        style: GoogleFonts.alice(
                            color: primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  : ListView.separated(
                      itemBuilder: (context, position) {
                        return GestureDetector(
                          onTap: () {
                            log("message${locationProvider.locationData!.latitude}");
                            log("message${locationProvider.locationData!.longitude}");

                            if(widget.type==AppConstant.onTheWay){
                              locationProvider.getLocation().then((value) {
                                Get.to(() => CategoryDetailsList(
                                  filter: {
                                    "shopType": categoryProvider
                                        .categoryList[position].title,
                                    "latitude": locationProvider
                                        .locationData!.latitude
                                        .toString(),
                                    "longitude": locationProvider
                                        .locationData!.longitude
                                        .toString()
                                  },
                                ));
                              });
                            } else if(widget.type==AppConstant.premiumShop){
                              locationProvider.getLocation().then((value) {
                                Get.to(() => CategoryDetailsList(
                                  filter: {
                                    "shopType": categoryProvider
                                        .categoryList[position].title,
                                    "latitude": locationProvider
                                        .locationData!.latitude
                                        .toString(),
                                    "longitude": locationProvider
                                        .locationData!.longitude
                                        .toString(),
                                    "isPremium":"true"
                                  },
                                ));
                              });
                            }

                            else{
                              Get.to(() => CategoryDetailsList(
                                filter: {
                                  "shopType": categoryProvider
                                      .categoryList[position].title,
                                  "latitude": locationProvider
                                      .locationData!.latitude
                                      .toString(),
                                  "longitude": locationProvider
                                      .locationData!.longitude
                                      .toString(),
                                },
                              ));
                            }

                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Row(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: grey),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        categoryProvider
                                                .categoryList[position].image ??
                                            "",
                                        height: 20,
                                        width: 20,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .72,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        categoryProvider
                                                .categoryList[position].title ??
                                            "",
                                        style: GoogleFonts.alice(
                                            color: textBlack,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        categoryProvider.categoryList[position]
                                                .subTitle ??
                                            "",
                                        style: GoogleFonts.alice(fontSize: 16),
                                      ),
                                      Text(
                                        "Starting ₹${categoryProvider.categoryList[position].minPrice ?? ""}",
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
                      itemCount: categoryProvider.categoryList.length,
                    )),
    );
  }
}
