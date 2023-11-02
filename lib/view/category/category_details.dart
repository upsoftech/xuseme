import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:xuseme/constant/color.dart';
import 'package:xuseme/constant/image.dart';
import 'package:xuseme/services/preference_services.dart';
import 'package:xuseme/utils/utility.dart';

import '../../constant/api_constant.dart';
import '../../constant/app_constants.dart';
import '../../provider/inquiry_provider.dart';
import '../../provider/location_provider.dart';
import '../../provider/sub_category_provider.dart';
import '../../services/api_services.dart';
import '../widgets/custom_image_view.dart';

class CategoryDetailsList extends StatefulWidget {
  const CategoryDetailsList({Key? key, required this.filter, this.type})
      : super(key: key);

  final Map<String, dynamic> filter;
  final String? type;

  @override
  State<CategoryDetailsList> createState() => _CategoryDetailsListState();
}

class _CategoryDetailsListState extends State<CategoryDetailsList> {
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
    final locationProvider = Provider.of< LocationProvider>(context);
    // log("${widget.filter["latitude"]}");
    // log("${widget.filter["longitude"]}");

    log("${widget.filter}");

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
                      return Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: primary.withOpacity(.1),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await showDialog(
                                          context: context,
                                          builder: (_) => ImageDialog(
                                                url:
                                                    "${ApiConstant.baseUrl}uploads/${subShopProvider.subShopList[index].shopLogo}",
                                              ));
                                    },
                                    child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: subShopProvider
                                                    .subShopList[index]
                                                    .shopLogo !=
                                                ""
                                            ? NetworkImage(
                                                "${ApiConstant.baseUrl}uploads/${subShopProvider.subShopList[index].shopLogo}")
                                            : NetworkImage(noImage)),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          subShopProvider
                                                  .subShopList[index].shopName ??
                                              "",
                                          style: GoogleFonts.alice(
                                              color: textBlack,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          "Owner Name : ${subShopProvider.subShopList[index].name ?? ""}",
                                          style: GoogleFonts.alice(
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "My business Address:",
                                style: GoogleFonts.alice(
                                    fontSize: 16,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${subShopProvider.subShopList[index].address ?? ""} ${subShopProvider.subShopList[index].landmark ?? ""} ${subShopProvider.subShopList[index].pincode ?? ""} ${subShopProvider.subShopList[index].state ?? ""}",
                                style: GoogleFonts.alice(fontSize: 16),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "My Services:",
                                style: GoogleFonts.alice(
                                    fontSize: 16,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                subShopProvider.subShopList[index].services ??
                                    "",
                                style: GoogleFonts.alice(fontSize: 16),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${Utility.calculateDistance(double.parse(locationProvider
                                        .locationData!.latitude
                                        .toString()), double.parse(locationProvider
                                        .locationData!.longitude
                                        .toString()), subShopProvider.subShopList[index].latitude ?? 0, subShopProvider.subShopList[index].longitude ?? 0)} KM Away",
                                    style: GoogleFonts.alice(
                                        color: primary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          final phoneNumber = Uri.encodeComponent(
                                              "+91${subShopProvider.subShopList[index].mobile}");
                                          final message =
                                              Uri.encodeComponent("Hi");

                                          final whatsappUrl = 'whatsapp://send?phone=$phoneNumber&text=${Uri.encodeComponent(message)}';
                                          launchUrlString(whatsappUrl);
                                        },
                                        child: Image.asset(
                                          whatsapp,
                                          height: 40,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          log("message111${subShopProvider.subShopList[index].mobile}");
                                          launchUrl(Uri.parse(
                                              "tel:${subShopProvider.subShopList[index].mobile}"));
                                          ApiServices().callInquiry({
                                            "customerId":
                                                PrefService().getRegId(),
                                            "partnerId": subShopProvider
                                                    .subShopList[index].id ??
                                                "",
                                            "type": "cold"
                                          }).then((value) {
                                            Fluttertoast.showToast(
                                                msg: "$value",
                                                backgroundColor: primaryColor);
                                          });
                                        },
                                        child: const CircleAvatar(
                                            radius: 15,
                                            backgroundColor: primary,
                                            child: Icon(
                                              Icons.call,
                                              color: textWhite,
                                              size: 20,
                                            )),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          log("message111${subShopProvider.subShopList[index].landline}");
                                          launchUrl(Uri.parse(
                                              "tel:${subShopProvider.subShopList[index].landline}"));
                                          ApiServices().callInquiry({
                                            "customerId":
                                                PrefService().getRegId(),
                                            "partnerId": subShopProvider
                                                    .subShopList[index].id ??
                                                "",
                                            "type": "cold"
                                          }).then((value) {
                                            Fluttertoast.showToast(
                                                msg: "$value",
                                                backgroundColor: primaryColor);
                                          });
                                        },
                                        child: const CircleAvatar(
                                            radius: 15,
                                            backgroundColor: primary,
                                            child: Icon(
                                              Icons.call,
                                              color: textWhite,
                                              size: 20,
                                            )),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ));
                    }));
  }
}
