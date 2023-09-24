import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:xuseme/constant/api_constant.dart';
import 'package:xuseme/constant/image.dart';
import 'package:xuseme/provider/profile_provider.dart';
import '../../../services/preference_services.dart';
import '../../../constant/color.dart';
import '../../vendor/edit_vndor_profile.dart';
import '../../widgets/custom_image_view.dart';
import 'address_page.dart';
import 'edit_profile.dart';
import 'inquiry_page.dart';

class UserAccount extends StatefulWidget {
  const UserAccount({Key? key}) : super(key: key);

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  final PrefService _prefService = PrefService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<ProfileProvider>(context, listen: false).getProfile();
    Provider.of<ProfileProvider>(context, listen: false).vendorProfile();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Profile",
          style: GoogleFonts.alice(
              color: textWhite, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<ProfileProvider>(builder: (context, value, child) {
        //log("message${value.vendorProfileData}");
        return ListView(
          children: [
            _prefService.getSelectType() == "customer"
                ? Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    padding: const EdgeInsets.only(
                        left: 10, right: 15, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: grey),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            spreadRadius: 1,
                          )
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${value.profileData["name"] ?? ""}",
                              style: GoogleFonts.alice(
                                  fontSize: 18,
                                  color: textBlack,
                                  fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                                onTap: () {
                                Get.to(()=>EditProfile(
                                    data: profileProvider.profileData,
                                  ));
                                },
                                child: Text(
                                  "Edit",
                                  style: GoogleFonts.alice(
                                      fontSize: 20,
                                      color: secondry,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        Row(
                          children: [
                            Text(
                              "Mobile No.",
                              style: GoogleFonts.alice(
                                  fontSize: 14,
                                  color: grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .1,
                            ),
                            Text(
                              "${value.profileData["mobile"] ?? ""}",
                              style: GoogleFonts.alice(
                                  fontSize: 14,
                                  color: grey,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        Row(
                          children: [
                            Text(
                              "Email",
                              style: GoogleFonts.alice(
                                  fontSize: 14,
                                  color: grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .18,
                            ),
                            Text(
                              "${value.profileData["email"] ?? ""}",
                              style: GoogleFonts.alice(
                                  fontSize: 14,
                                  color: grey,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        GestureDetector(
                          onTap: () {
                          Get.to(()=>const AddressPage());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            height: 45,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: primaryColor.withOpacity(.2),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Address",
                                  style: GoogleFonts.alice(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: textBlack),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: textBlack,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                          Get.to(()=>const InquiryPage());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            height: 45,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: primaryColor.withOpacity(.2),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Inquiry",
                                  style: GoogleFonts.alice(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: textBlack),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: textBlack,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            _prefService.getSelectType() == "partner"
                ? Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        // border: Border.all(color: grey),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            spreadRadius: 1,
                          )
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await showDialog(
                                context: context,
                                builder: (_) => ImageDialog(
                                  url: value.vendorProfileData["shopLogo"]!=null &&
                                      value.vendorProfileData["shopLogo"]!=""?
                                  ApiConstant.baseUrl+"uploads/"+ value.vendorProfileData["shopLogo"] :noImage,
                                ));
                              },
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: primaryColor,
                                backgroundImage: NetworkImage(
                                    value.vendorProfileData["shopLogo"]!=null &&
                                    value.vendorProfileData["shopLogo"]!=""?
                                   ApiConstant.baseUrl+"uploads/"+ value.vendorProfileData["shopLogo"] :noImage ),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                Get.to(()=>EditVendorProfile(
                                   data: value.vendorProfileData,
                                  ));
                                },
                                child: Text(
                                  "Edit",
                                  style: GoogleFonts.alice(
                                      fontSize: 20,
                                      color: secondry,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),


                        Row(
                          children: [
                            Text(
                              "Name :",
                              style: GoogleFonts.alice(
                                  fontSize: 14,
                                  color: grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .18,
                            ),
                            Text(
                              "${value.vendorProfileData["name"] ?? ""}",
                              style: GoogleFonts.alice(
                                  fontSize: 14,
                                  color: grey,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        Row(
                          children: [
                            Text(
                              "Mobile No. :",
                              style: GoogleFonts.alice(
                                  fontSize: 14,
                                  color: grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .1,
                            ),
                            Text(
                              "${value.vendorProfileData["mobile"] ?? ""}",
                              style: GoogleFonts.alice(
                                  fontSize: 14,
                                  color: grey,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        Row(
                          children: [
                            Text(
                              "Email :",
                              style: GoogleFonts.alice(
                                  fontSize: 14,
                                  color: grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .18,
                            ),
                            Text(
                              "${value.vendorProfileData["email"] ?? ""}",
                              style: GoogleFonts.alice(
                                  fontSize: 14,
                                  color: grey,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        Row(
                          children: [
                            Text(
                              "Shop Name :",
                              style: GoogleFonts.alice(
                                  fontSize: 14,
                                  color: grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .09,
                            ),
                            Text(
                              "${value.vendorProfileData["shopName"] ?? ""}",
                              style: GoogleFonts.alice(
                                  fontSize: 14,
                                  color: grey,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        Row(
                          children: [
                            Text(
                              "Landline No. :",
                              style: GoogleFonts.alice(
                                  fontSize: 14,
                                  color: grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .07,
                            ),
                            Text(
                              "${value.vendorProfileData["landline"] ?? ""}",
                              style: GoogleFonts.alice(
                                  fontSize: 14,
                                  color: grey,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        Row(
                          children: [
                            Text(
                              "Shop Type :",
                              style: GoogleFonts.alice(
                                  fontSize: 14,
                                  color: grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .11,
                            ),
                            Text(
                              "${value.vendorProfileData["shopType"] ?? ""}",
                              style: GoogleFonts.alice(
                                  fontSize: 14,
                                  color: grey,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        Row(
                          children: [
                            Text(
                              "Services :",
                              style: GoogleFonts.alice(
                                  fontSize: 14,
                                  color: grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .14,
                            ),
                            Text(
                              "${value.vendorProfileData["services"] ?? ""}",
                              style: GoogleFonts.alice(
                                  fontSize: 14,
                                  color: grey,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .14,
                        ),
                        Text(
                          "${value.vendorProfileData["address"] ?? ""} ${value.vendorProfileData["landmark"] ?? ""} ${value.vendorProfileData["pincode"] ?? ""} ${value.vendorProfileData["state"] ?? ""}",
                          style: GoogleFonts.alice(
                              fontSize: 14,
                              color: grey,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                : const SizedBox()
          ],
        );
      }),
    );
  }
}
