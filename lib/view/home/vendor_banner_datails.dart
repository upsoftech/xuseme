import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../constant/api_constant.dart';
import '../../constant/color.dart';
import '../../constant/image.dart';
import '../../model/sub_category_model.dart';
import '../../provider/location_provider.dart';
import '../../provider/sub_category_provider.dart';
import '../../services/api_services.dart';
import '../../services/preference_services.dart';
import '../../utils/utility.dart';
import '../widgets/custom_image_view.dart';

class VendorBannerDetails extends StatefulWidget {
  const VendorBannerDetails({super.key, required this.id,});

  final String id;
  @override
  State<VendorBannerDetails> createState() => _VendorBannerDetailsState();
}

class _VendorBannerDetailsState extends State<VendorBannerDetails> {

  late SubShopsProvider subShopProvider;


  @override
  void initState() {
    super.initState();
    subShopProvider = Provider.of<SubShopsProvider>(context, listen: false);

    subShopProvider.getVendorById(widget.id);

  }


  @override
  Widget build(BuildContext context) {
    subShopProvider = Provider.of<SubShopsProvider>(context);

    final locationProvider = Provider.of<LocationProvider>(context);
    log("${subShopProvider.vendorData?.offers}");
    log("${subShopProvider.vendorData?.premiumOffers}");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body:subShopProvider.vendorData!=null? Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          width: double.infinity,
          decoration: BoxDecoration(
              color: primary.withOpacity(.1),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              subShopProvider.vendorData!.offers!.isNotEmpty
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: ImageSlideshow(
                    width: double.infinity,
                    initialPage: 0,
                    indicatorColor: primaryColor,
                    indicatorBackgroundColor: grey,
                    autoPlayInterval: 3000,
                    isLoop: true,
                    children: subShopProvider.vendorData!.offers!.map((e) {
                      return e["offerImage"].toString() != ""
                          ? Image.network(
                        // ignore: prefer_interpolation_to_compose_strings
                        "${ApiConstant.baseUrl}/uploads/banners/" +
                            e["offerImage"],
                        fit: BoxFit.cover,
                      )
                          : Image.network(
                        noImage,
                        fit: BoxFit.cover,
                      );
                    }).toList()),
              )
                  : const SizedBox(),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (_) => ImageDialog(
                            url: subShopProvider.vendorData!.shopLogo != ""
                                ? "${ApiConstant.baseUrl}uploads/${subShopProvider.vendorData!.shopLogo}"
                                : noImage,
                          ));
                    },
                    child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        backgroundImage: subShopProvider.vendorData!.shopLogo != ""
                            ? NetworkImage(
                            "${ApiConstant.baseUrl}uploads/${subShopProvider.vendorData!.shopLogo}")
                            : const NetworkImage(noImage)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (subShopProvider.vendorData!.shopName ?? "").toUpperCase(),
                          style: GoogleFonts.alice(
                              color: textBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        Text(
                          "Owner Name : ${subShopProvider.vendorData!.name ?? ""}".toUpperCase(),
                          style: GoogleFonts.alice(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
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
                "My business Address:".toUpperCase(),
                style: GoogleFonts.alice(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                ("${subShopProvider.vendorData!.address ?? ""} ${subShopProvider.vendorData!.landmark ?? ""} "
                    "${subShopProvider.vendorData!.pincode ?? ""} ${subShopProvider.vendorData!.state ?? ""}").toUpperCase(),
                style: GoogleFonts.alice(fontSize: 14),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                ("My Services: ${subShopProvider.vendorData!.services}").toUpperCase(),
                style: GoogleFonts.alice(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                "${subShopProvider.vendorData!.services}".toUpperCase(),
                style: GoogleFonts.alice(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: primary.withOpacity(.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${Utility.calculateDistance(double.parse(locationProvider.locationData!.latitude.toString()), double.parse(locationProvider.locationData!.longitude.toString()), subShopProvider.vendorData?.latitude ?? 0, subShopProvider.vendorData?.longitude ?? 0)} KM Away",
                      style: GoogleFonts.alice(
                          color: primary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            try {
                              var phoneNumber = subShopProvider.vendorData
                                  !.mobile; // Replace with the recipient's phone number
                              const message =
                                  'Hey! I\'m inquiring about the apartment listing';

                              // Construct the WhatsApp URL
                              final whatsappUrl =
                                  'whatsapp://send?phone=$phoneNumber&text=${Uri.encodeComponent(message)}';

                              // Launch the URL using the url_launcher package
                              await launchUrlString(whatsappUrl);
                            } catch (e) {
                              print(e);
                            }
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
                            launchUrl(Uri.parse("tel://${subShopProvider.vendorData!.mobile}"));
                            ApiServices().callInquiry({
                              "customerId": PrefService().getRegId(),
                              "partnerId": subShopProvider.vendorData!.id ?? "",
                              "type": "cold"
                            }).then((value) {
                              Fluttertoast.showToast(
                                  msg: "$value", backgroundColor: primaryColor);
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
                            launchUrl(Uri.parse("tel://${subShopProvider.vendorData!.landline}"));
                            ApiServices().callInquiry({
                              "customerId": PrefService().getRegId(),
                              "partnerId": subShopProvider.vendorData!.id ?? "",
                              "type": "cold"
                            }).then((value) {
                              Fluttertoast.showToast(
                                  msg: "$value", backgroundColor: primaryColor);
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
              )
            ],
          ))
      :const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
