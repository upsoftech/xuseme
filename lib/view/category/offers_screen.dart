import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:xuseme/constant/color.dart';
import 'package:xuseme/view/category/vendor_details.dart';

import '../../constant/api_constant.dart';
import '../../constant/app_constants.dart';
import '../../provider/inquiry_provider.dart';
import '../../provider/sub_category_provider.dart';

class OfferScreen extends StatefulWidget {
  const OfferScreen({Key? key, required this.filter, this.type})
      : super(key: key);

  final Map<String, dynamic> filter;
  final String? type;

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  late SubShopsProvider subShopProvider;
  late InquiryProvider inquiryProvider;

  @override
  void initState() {
    super.initState();
    subShopProvider = Provider.of<SubShopsProvider>(context, listen: false);

    subShopProvider.getShopData(widget.filter);
    inquiryProvider = Provider.of<InquiryProvider>(context, listen: false);

    log("message444444${inquiryProvider.offerAdHistoryList}");
  }

  final searchTextController = TextEditingController();

  final SpeechToText _speechToText = SpeechToText();

  bool _speechEnabled = false;
  String _lastWords = '';

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

    log("message11${result.recognizedWords}");
  }

  @override
  Widget build(BuildContext context) {
    subShopProvider = Provider.of<SubShopsProvider>(context);
    inquiryProvider = Provider.of<InquiryProvider>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          title: Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: TextFormField(
              cursorColor: textWhite,
              style: const TextStyle(color: textWhite),
              controller: searchTextController,
              onChanged: (v) {
                if (v.trim() != "") {
                  subShopProvider.getShopData({"search": v});
                } else {
                  subShopProvider.getShopData(widget.filter);
                }
              },
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: textWhite),
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: textWhite),
                      borderRadius: BorderRadius.circular(10)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: ('Search here'),
                  labelStyle: GoogleFonts.alice(color: textWhite),
                  contentPadding: const EdgeInsets.only(top: 10, left: 20),
                  suffixIcon: SizedBox(
                    width: AppConstant.width(context) * 0.3,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              subShopProvider.getShopData(
                                  {"search": searchTextController.text.trim()});
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
        body: subShopProvider.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              )
            : subShopProvider.subShopList.isEmpty
                ? Center(
                    child: Text(
                      "No Data Found",
                      style: GoogleFonts.alice(
                          color: primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                : ListView.builder(
                    itemCount: subShopProvider.subShopList.length,
                    // physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      if (subShopProvider.subShopList[index].offers != null &&
                          subShopProvider
                              .subShopList[index].offers!.isNotEmpty) {
                        return subShopProvider
                                .subShopList[index].offers!.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  Get.to(() => VendorDetails(
                                        shopSubCategoryModel:
                                            subShopProvider.subShopList[index],
                                      ));
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(7),
                                  child: Column(
                                      children: subShopProvider
                                          .subShopList[index].offers!
                                          .map((e) {
                                    return e["offerImage"].toString() != ""
                                        ? Container(
                                            margin: const EdgeInsets.all(5),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(11),
                                              child: Image.network(
                                                // ignore: prefer_interpolation_to_compose_strings
                                                "${ApiConstant.baseUrl}/uploads/banners/" +
                                                    e["offerImage"],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                        : const SizedBox();
                                  }).toList()),
                                ),
                              )
                            : const SizedBox();
                      }
                      return const SizedBox();
                    }));
  }
}
