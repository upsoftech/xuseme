import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../constant/color.dart';
import '../../provider/category_provider.dart';
import '../../provider/location_provider.dart';
import '../category/category_details.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({super.key});

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  final cityController = TextEditingController();
  final pinCodeController = TextEditingController();

  String? selectState;
  String? shopTypes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CategoryProvider>(context, listen: false)
        .getCategoryData(query: '');
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final catProvider = Provider.of<CategoryProvider>(context);
    final locationProvider = Provider.of<LocationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Global Search",
          style: GoogleFonts.alice(
              color: textWhite, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: TextFormField(
                  cursorColor: Colors.black,
                  controller: cityController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: textBlack),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: textBlack),
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: ('Enter City Name'),
                    labelStyle: GoogleFonts.alice(),
                    contentPadding: const EdgeInsets.only(top: 10, left: 20),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select City';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: TextFormField(
                  controller: pinCodeController,
                  onChanged: (v) {
                    if (v.length >= 7) {
                      pinCodeController.text = "";
                      Fluttertoast.showToast(
                          msg: "Only Required 6 digit",
                          backgroundColor: primaryColor);
                    }
                  },
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: textBlack),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: textBlack),
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: ('Pin Code'),
                    labelStyle: GoogleFonts.alice(),
                    contentPadding: const EdgeInsets.only(top: 10, left: 20),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: textBlack),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: textBlack),
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Select State ',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    labelStyle: GoogleFonts.alice(),
                  ),
                  value: selectState,
                  items: const [
                    DropdownMenuItem<String>(
                      value: "Andhra Pradesh",
                      child: Text("Andhra Pradesh"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Arunachal Pradesh",
                      child: Text("Arunachal Pradesh"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Assam",
                      child: Text("Assam"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Bihar",
                      child: Text("Bihar"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Chhattisgarh",
                      child: Text("Chhattisgarh"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Goa",
                      child: Text("Goa"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Gujarat",
                      child: Text("Gujarat"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Haryana",
                      child: Text("Haryana"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Himachal Pradesh",
                      child: Text("Himachal Pradesh"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Jharkhand",
                      child: Text("Jharkhand"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Karnataka",
                      child: Text("Karnataka"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Kerala",
                      child: Text("Kerala"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Madhya Pradesh",
                      child: Text("Madhya Pradesh"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Maharashtra",
                      child: Text("Maharashtra"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Manipur",
                      child: Text("Manipur"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Meghalaya",
                      child: Text("Meghalaya"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Mizoram",
                      child: Text("Mizoram"),
                    ),
                    DropdownMenuItem<String>(
                      value: "New Delhi",
                      child: Text("New Delhi"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Nagaland",
                      child: Text("Nagaland"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Odisha",
                      child: Text("Odisha"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Punjab",
                      child: Text("Punjab"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Rajasthan",
                      child: Text("Rajasthan"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Sikkim",
                      child: Text("Sikkim"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Tamil Nadu",
                      child: Text("Tamil Nadu"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Telangana",
                      child: Text("Telangana"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Tripura",
                      child: Text("Tripura"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Uttar Pradesh",
                      child: Text("Uttar Pradesh"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Uttarakhand",
                      child: Text("Uttarakhand"),
                    ),
                    DropdownMenuItem<String>(
                      value: "West Bengal",
                      child: Text("West Bengal"),
                    ),
                  ],
                  onChanged: (String? newStateId) {
                    selectState = newStateId;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: DropdownButtonFormField<String>(
                  key: UniqueKey(),
                  isExpanded: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: textBlack),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: textBlack),
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Shop Type ',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    labelStyle: GoogleFonts.alice(),
                  ),
                  value: shopTypes,
                  items: catProvider.categoryList.map((e) {
                    return DropdownMenuItem<String>(
                      value: e.title,
                      child: Text(
                        "${e.title}",
                        style: GoogleFonts.alice(),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newStateId) {
                    setState(() {
                      shopTypes = newStateId!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select Shop type';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
              ),
              GestureDetector(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    Provider.of<LocationProvider>(context, listen: false)
                        .getCoordinatesFromAddress(
                            "${cityController.text.trim()}, "
                            "${pinCodeController.text.trim()}, "
                            "$selectState ,")
                        .then((value) {
                      log("message : ${locationProvider.locationData!}");
                      Get.to(() => CategoryDetailsList(
                            filter: {
                              "address": cityController.text.trim(),
                              "pincode": pinCodeController.text.trim(),
                              "state": selectState,
                              "shopType": shopTypes,
                              /*"latitude": locationProvider
                                  .locationData!.latitude
                                  .toString(),
                              "longitude": locationProvider
                                  .locationData!.longitude
                                  .toString()*/
                            },
                          ));
                    });
                  } else {
                    Fluttertoast.showToast(msg: "Please fill correct address");
                  }
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: textBlack,
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    "Search",
                    style: GoogleFonts.alice(
                        color: textWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
