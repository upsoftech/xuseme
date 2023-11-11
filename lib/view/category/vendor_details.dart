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
import '../../services/api_services.dart';
import '../../services/preference_services.dart';
import '../../utils/utility.dart';
import '../widgets/custom_image_view.dart';

class VendorDetails extends StatefulWidget {
  const VendorDetails({super.key, required this.shopSubCategoryModel});

  final ShopSubCategoryModel shopSubCategoryModel;

  @override
  State<VendorDetails> createState() => _VendorDetailsState();
}

class _VendorDetailsState extends State<VendorDetails> {
  @override
  Widget build(BuildContext context) {
    var data = widget.shopSubCategoryModel;

    final locationProvider = Provider.of<LocationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Container(
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
              data.offers!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(11),
                      child: ImageSlideshow(
                          width: double.infinity,
                          initialPage: 0,
                          indicatorColor: primaryColor,
                          indicatorBackgroundColor: grey,
                          autoPlayInterval: 3000,
                          isLoop: true,
                          children: data.offers!.map((e) {
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
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (_) => ImageDialog(
                                url: data.shopLogo != ""
                                    ? "${ApiConstant.baseUrl}uploads/${data.shopLogo}"
                                    : noImage,
                              ));
                    },
                    child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30,
                        backgroundImage: data.shopLogo != ""
                            ? NetworkImage(
                                "${ApiConstant.baseUrl}uploads/${data.shopLogo}")
                            : const NetworkImage(noImage)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          (data.shopName ?? "").toUpperCase(),
                          style: GoogleFonts.alice(
                              color: textBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        Text(
                          ("Owner Name : ${data.name ?? ""}").toUpperCase(),
                          style: GoogleFonts.alice(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
                ("${data.address ?? ""} ${data.landmark ?? ""} ${data.pincode ?? ""} ${data.state ?? ""}")
                    .toUpperCase(),
                style: GoogleFonts.alice(fontSize: 14),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "My Services : ".toUpperCase(),
                style: GoogleFonts.alice(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                "${data.services}".toUpperCase(),
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
                      "${Utility.calculateDistance(double.parse(locationProvider.locationData!.latitude.toString()), double.parse(locationProvider.locationData!.longitude.toString()), data?.latitude ?? 0, data?.longitude ?? 0)} KM Away",
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
                              var phoneNumber = data
                                  .mobile; // Replace with the recipient's phone number
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
                            launchUrl(Uri.parse("tel://${data.mobile}"));
                            ApiServices().callInquiry({
                              "customerId": PrefService().getRegId(),
                              "partnerId": data.id ?? "",
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
                            launchUrl(Uri.parse("tel://${data.landline}"));
                            ApiServices().callInquiry({
                              "customerId": PrefService().getRegId(),
                              "partnerId": data.id ?? "",
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
          )),
    );
  }
}
