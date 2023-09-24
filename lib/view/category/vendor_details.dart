import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../constant/api_constant.dart';
import '../../constant/color.dart';
import '../../constant/image.dart';
import '../../model/sub_category_model.dart';
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
                  : SizedBox(),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                        radius: 30,
                        backgroundImage: data.shopLogo != ""
                            ? NetworkImage(
                                "${ApiConstant.baseUrl}uploads/${data.shopLogo}")
                            : NetworkImage(noImage)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        data.shopName ?? "",
                        style: GoogleFonts.alice(
                            color: textBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 21),
                      ),
                      Text(
                        "Owner Name : ${data.name ?? ""}",
                        style: GoogleFonts.alice(
                            color: primaryColor,
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
                    color: primaryColor,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "${data.address ?? ""} ${data.landmark ?? ""} ${data.pincode ?? ""} ${data.state ?? ""}",
                style: GoogleFonts.alice(fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "My Services: ${data.services}",
                style: GoogleFonts.alice(
                    fontSize: 16,
                    color: primaryColor,
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
                      "${Utility.calculateDistance(double.parse("0"), double.parse("0"), data.latitude ?? 0, data.longitude ?? 0)} KM Away",
                      style: GoogleFonts.alice(
                          color: primary,
                          fontSize: 16,
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
