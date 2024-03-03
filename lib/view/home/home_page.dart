import 'dart:developer';

import 'package:cc_avenue/cc_avenue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuseme/constant/api_constant.dart';
import 'package:xuseme/constant/app_constants.dart';
import 'package:xuseme/constant/image.dart';
import 'package:xuseme/provider/home_provider.dart';
import 'package:xuseme/provider/location_provider.dart';
import 'package:xuseme/utils/utility.dart';
import 'package:xuseme/view/home/remote_search.dart';
import 'package:xuseme/view/home/vendor_banner_datails.dart';
import 'package:xuseme/view/widgets/custom_web_view.dart';

import '../../constant/color.dart';
import '../../provider/profile_provider.dart';
import '../../services/preference_services.dart';
import '../category/category_list.dart';
import '../category/offers_screen.dart';
import '../drawer/account/user_account.dart';
import '../drawer/drawer_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late LocationProvider locationProvider;
  late HomeProvider homeProvider;
  late ProfileProvider profileProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    newLoad();
  }

  newLoad() async {
    await Future.delayed(const Duration(seconds: 4), () {
      if (homeProvider.topBannerList.isEmpty ||
          homeProvider.bottomBannerList.isEmpty ||
          homeProvider.singleBannerList.isEmpty) {
        loadData();
      }
    });
  }

  loadData() async {
    locationProvider = Provider.of<LocationProvider>(context, listen: false);
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    profileProvider.getProfile();
    profileProvider.vendorProfile();

    locationProvider.getLocation().then((value) {
      locationProvider.getCoordinatesFromAddress(
        '${locationProvider.placeMark?.first.subLocality},'
        ' ${locationProvider.placeMark?.first.locality}, '
        ' ${locationProvider.placeMark?.first.postalCode}'
        ' ${locationProvider.placeMark?.first.subAdministrativeArea}',
      );
      homeProvider.getTopBanner(
          locationProvider.locationData!.latitude.toString(),
          locationProvider.locationData!.longitude.toString());
      homeProvider.getBottomBanner(
          locationProvider.locationData!.latitude.toString(),
          locationProvider.locationData!.longitude.toString());
      homeProvider.getSingleBanner(
          locationProvider.locationData!.latitude.toString(),
          locationProvider.locationData!.longitude.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    locationProvider = Provider.of<LocationProvider>(context);
    homeProvider = Provider.of<HomeProvider>(context);
    profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      drawer: const DrawerPage(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          '${locationProvider.placeMark?.first.subLocality ?? ""},'
          ' ${locationProvider.placeMark?.first.locality ?? ""}',
          style: GoogleFonts.salsa(fontSize: 16, color: textWhite),
        ),
        actions: [
          /* IconButton(
              onPressed: () {
               //NotificationService.showLocalNotification();
               // NotificationService.sendNotification();
                var fat = PrefService().getFcmToken();
                log("kkkkkkkkkkkkkkk : $fat");
              },
              icon: Icon(Icons.notifications_none)),*/
 /*         IconButton(
              onPressed: () async {
                var trID =
                    "${DateTime
                    .now()
                    .millisecondsSinceEpoch}_${AppConstant
                    .regId}";
                final prefs = await SharedPreferences
                    .getInstance();
                prefs.setString("trId", trID).then((
                    value) async {
                  var value2 = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const MyWebViewScreen(
                              url:
                              "https://xuseme.com/payment/?mobile=8743979965&amount=1500&order_id=123456789",
                            )),
                  );
                  log("NEW TRY ON DASH BOARD $value2");
                  Fluttertoast.showToast(
                      msg: "${value2["code"]}");
                  if (value2["code"] != "PAYMENT_SUCCESS") {
                    Fluttertoast.showToast(
                        msg: "Payment failed");
                  } else
                  if (value2["code"] == "PAYMENT_SUCCESS") {

                    Fluttertoast.showToast(
                        msg: "Payment Successful");


                  } else {
                    Fluttertoast.showToast(
                        msg: "Something went wrong");
                  }
                });
                *//*CcAvenue.cCAvenueInit(
                        transUrl:
                            'https://secure.ccavenue.com/transaction/initTrans',
                        accessCode: '4YRUXLSRO20O8NIH',
                        amount: '1',
                        cancelUrl:
                            'http://122.182.6.216/merchant/ccavResponseHandler.jsp',
                        currencyType: 'INR',
                        merchantId: '2',
                        orderId: '519',
                        redirectUrl:
                            'http://122.182.6.216/merchant/ccavResponseHandler.jsp',
                        rsaKeyUrl:
                            'https://secure.ccavenue.com/transaction/jsp/GetRSA.jsp')
                    .catchError((err) {
                  log("Error : $err");
                });*//*
              },
              icon: const Icon(Icons.paypal)),*/
          GestureDetector(
            onTap: () {
              Get.to(() => const UserAccount());
            },
            child: PrefService().getSelectType() == "customer"
                ? Consumer<ProfileProvider>(builder: (context, value, _) {
                    log("message${value.profileData["shopLogo"]}");
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CircleAvatar(
                        radius: 31,
                        backgroundImage: NetworkImage(value
                                        .profileData["profileLogo"] !=
                                    null &&
                                value.profileData["profileLogo"] != ""
                            // ignore: prefer_interpolation_to_compose_strings
                            ? "${ApiConstant.baseUrl}uploads/" +
                                value.profileData["profileLogo"]
                            : noImage),
                      ),
                    );
                  })
                : Consumer<ProfileProvider>(builder: (context, value, _) {
                    log("message${value.profileData["shopLogo"]}");
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CircleAvatar(
                        radius: 31,
                        backgroundImage: NetworkImage(value
                                        .vendorProfileData["shopLogo"] !=
                                    null &&
                                value.vendorProfileData["shopLogo"] != ""
                            // ignore: prefer_interpolation_to_compose_strings
                            ? "${ApiConstant.baseUrl}uploads/" +
                                value.vendorProfileData["shopLogo"]
                            : noImage),
                      ),
                    );
                  }),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          loadData();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*

             Uncomment for serach

             Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextFormField(
                  cursorColor: Colors.black,
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
                      labelText: ('Search here'),
                      labelStyle: GoogleFonts.alice(),
                      contentPadding: const EdgeInsets.only(top: 10, left: 20),
                      suffixIcon: SizedBox(
                        width: AppConstants.width(context) * 0.3,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {}, icon: const Icon(Icons.search)),
                            const Text('|'),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.mic,
                                  color: textBlack,
                                ))
                          ],
                        ),
                      )),
                ),
              ),*/

              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Consumer<HomeProvider>(builder: (context, value, child) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: value.topBannerList.isNotEmpty
                        ? ImageSlideshow(
                            width: double.infinity,
                            height: 200,
                            initialPage: 0,
                            indicatorColor: primaryColor,
                            indicatorBackgroundColor: grey,
                            onPageChanged: (value) {
                              //  print('Page changed: $value');
                            },
                            autoPlayInterval: 10000,
                            isLoop: true,
                            children: value.topBannerList.map((e) {
                              return e["bannerImage"].toString() != ""
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    VendorBannerDetails(
                                                      id: e["partnerId"],
                                                    )));
                                      },
                                      child: Image.network(
                                        // ignore: prefer_interpolation_to_compose_strings
                                        "${ApiConstant.baseUrl}/uploads/banners/" +
                                            e["bannerImage"],
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Image.network(
                                      noImage,
                                      fit: BoxFit.cover,
                                    );
                            }).toList())
                        : const SizedBox(height: 150),
                  );
                }),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.to(() => const CategoryList(type: "local"));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              locations,
                              height: 30,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Local\nShopkeepers',
                              style: GoogleFonts.salsa(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        )),
                    GestureDetector(
                        onTap: () {
                          Get.to(() => CategoryList(
                                type: AppConstant.onTheWay,
                              ));
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              road,
                              height: 30,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Shopkeepers\nOn the way',
                              style: GoogleFonts.salsa(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        )),
                    GestureDetector(
                        onTap: () {
                          //  Get.to(() =>  CategoryList(type: AppConstant.normalShop,));
                          Get.to(() => OfferScreen(
                                filter: {
                                  "latitude": locationProvider
                                      .locationData!.latitude
                                      .toString(),
                                  "longitude": locationProvider
                                      .locationData!.longitude
                                      .toString(),
                                },
                              ));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              cart,
                              height: 30,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Shopkeeper's\nOffer",
                              style: GoogleFonts.salsa(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        )),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: const Divider(
                  color: grey,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.to(() => const SearchProduct());
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              searchLocation,
                              height: 34,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Global Search',
                              style: GoogleFonts.salsa(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )),
                    GestureDetector(
                        onTap: () {
                          Get.to(() => const UserAccount());
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              personalEdit,
                              height: 30,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Personal Details',
                              style: GoogleFonts.salsa(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )),
                    GestureDetector(
                        onTap: () {
                          //  Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigationPage(page: 2,)));

                          Get.to(() => CategoryList(
                              type: AppConstant.premiumShop, isPremium: true));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              myOffer,
                              height: 30,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Premium Shops',
                              style: GoogleFonts.salsa(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: const Divider(
                  color: grey,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Utility.myLaunchUrl(
                      homeProvider.singleBannerList.first["redirectUrl"] ??
                          "https://www.google.com/");
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  width: double.infinity,
                  height: AppConstant.height(context) * 0.15,
                  decoration: BoxDecoration(
                      color: grey.withOpacity(.1),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: homeProvider.singleBannerList.isNotEmpty
                              ? NetworkImage(ApiConstant.baseUrl +
                                  homeProvider
                                      .singleBannerList.first["offerImage"])
                              : const NetworkImage(noImage))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 10, bottom: 10),
                child: Consumer<HomeProvider>(builder: (context, value, _) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: value.bottomBannerList.isNotEmpty
                        ? ImageSlideshow(
                            width: double.infinity,
                            height: 200,
                            initialPage: 0,
                            indicatorColor: primaryColor,
                            indicatorBackgroundColor: grey,
                            onPageChanged: (value) {
                              //  print('Page changed: $value');
                            },
                            autoPlayInterval: 10000,
                            isLoop: true,
                            children: value.bottomBannerList.map((e) {
                              return e["bannerImage"].toString() != ""
                                  ? GestureDetector(
                                      onTap: () {
                                        log("partner Id : ${e["partnerId"]}");
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    VendorBannerDetails(
                                                      id: e["partnerId"],
                                                    )));
                                      },
                                      child: Image.network(
                                        // ignore: prefer_interpolation_to_compose_strings
                                        "${ApiConstant.baseUrl}/uploads/banners/" +
                                            e["bannerImage"],
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Image.network(
                                      noImage,
                                      fit: BoxFit.cover,
                                    );
                            }).toList())
                        : const SizedBox(height: 200),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
