import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:xuseme/api_services/preference_services.dart';
import 'package:xuseme/constant/color.dart';
import 'package:xuseme/constant/image.dart';

import '../../api_services/api_services.dart';
import '../../constant/api_constant.dart';
import '../../constant/app_constants.dart';
import '../../provider/sub_category_provider.dart';

class CategoryDetailsList extends StatefulWidget {
  const CategoryDetailsList({Key? key, required this.filter}) : super(key: key);

  final Map<String, dynamic> filter;

  @override
  State<CategoryDetailsList> createState() => _CategoryDetailsListState();
}

class _CategoryDetailsListState extends State<CategoryDetailsList> {
  late SubShopsProvider subShopProvider;

  @override
  void initState() {
    super.initState();
    subShopProvider = Provider.of<SubShopsProvider>(context, listen: false);

    subShopProvider.getShopData(widget.filter);
  }


  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    subShopProvider = Provider.of<SubShopsProvider>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: btnColor,
          elevation: 0,
          title: Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: TextFormField(
              cursorColor: textWhite,
              style: const TextStyle(color: textWhite),
              controller: searchController,
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
                    width: AppConstants.width(context) * 0.3,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              subShopProvider.getShopData({
                                "search":searchController.text.trim()
                              });
                            },
                            icon: const Icon(
                              Icons.search,
                              color: textWhite,
                            )),
                        const Text('|'),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.mic,
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
                  color: btnColor,
                ),
              )
            : subShopProvider.subShopList.isEmpty
                ? Center(
                    child: Text(
                      "No Data Found",
                      style: GoogleFonts.alice(
                          color: btnColor,
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
                              horizontal: 5, vertical: 10),
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
                                                url: ApiConstant.baseUrl +
                                                    subShopProvider
                                                        .subShopList[index]
                                                        .shopLogo
                                                        .toString(),
                                              ));
                                    },
                                    child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(
                                            subShopProvider
                                                .subShopList[index].shopLogo
                                                .toString())),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
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
                                            color: btnColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "My business Address:",
                                style: GoogleFonts.alice(
                                    fontSize: 16,
                                    color: btnColor,
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
                                    color: btnColor,
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
                                    "10 KM Away",
                                    style: GoogleFonts.alice(
                                        color: primary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        whatsapp,
                                        height: 40,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
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
                                                backgroundColor: btnColor);
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
                                          log("message${subShopProvider.subShopList[index].id}");

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
                                                backgroundColor: btnColor);
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

class ImageDialog extends StatelessWidget {
  const ImageDialog({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Image.network(url, fit: BoxFit.cover),
      ),
    ));
  }
}
