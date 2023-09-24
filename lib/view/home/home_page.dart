import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:xuseme/constant/api_constant.dart';
import 'package:xuseme/constant/app_constants.dart';
import 'package:xuseme/constant/image.dart';
import 'package:xuseme/provider/home_provider.dart';
import 'package:xuseme/provider/location_provider.dart';
import 'package:xuseme/services/preference_services.dart';
import 'package:xuseme/view/home/remote_search.dart';

import '../../constant/color.dart';
import '../../provider/profile_provider.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() {
    locationProvider = Provider.of<LocationProvider>(context, listen: false);

    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    profileProvider.getProfile();
    profileProvider.vendorProfile();
    locationProvider.getLocation().then((value) {
      locationProvider.getCoordinatesFromAddress(
        '${locationProvider.placeMark?.first.subLocality},'
        ' ${locationProvider.placeMark?.first.locality}, '
        ' ${locationProvider.placeMark?.first.postalCode}'
        ' ${locationProvider.placeMark?.first.subAdministrativeArea}',
      );
    });
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.getBanner();
    homeProvider.getSingleBanner();
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);

    log("message111 : ${homeProvider.singleBannerList}");
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: primaryColor,
          elevation: 0,
          title: ListTile(
            trailing: GestureDetector(
              onTap: () {
                Get.to(() => const UserAccount());
              },
              child: PrefService().getSelectType() == "customer"
                  ? Consumer<ProfileProvider>(builder: (context, value, _) {
                      log("message${value.profileData["shopLogo"]}");
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Image.network(
                            value.profileData["profileLogo"] != null &&
                                    value.profileData["profileLogo"] != ""
                                // ignore: prefer_interpolation_to_compose_strings
                                ? "${ApiConstant.baseUrl}uploads/" +
                                    value.profileData["profileLogo"]
                                : noImage),
                      );
                    })
                  : Consumer<ProfileProvider>(builder: (context, value, _) {
                      log("message${value.profileData["shopLogo"]}");
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Image.network(
                            value.vendorProfileData["shopLogo"] != null &&
                                    value.vendorProfileData["shopLogo"] != ""
                                // ignore: prefer_interpolation_to_compose_strings
                                ? "${ApiConstant.baseUrl}uploads/" +
                                    value.vendorProfileData["shopLogo"]
                                : noImage),
                      );
                    }),
            ),
            title: Text(
              '${locationProvider.placeMark?.first.subLocality ?? ""}, ${locationProvider.placeMark?.first.locality ?? ""}',
              style: GoogleFonts.salsa(fontSize: 16, color: textWhite),
            ),
          )),
      body: SingleChildScrollView(
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: homeProvider.bannerList.isNotEmpty
                    ? ImageSlideshow(
                        width: double.infinity,
                        height: 200,
                        initialPage: 0,
                        indicatorColor: primaryColor,
                        indicatorBackgroundColor: grey,
                        onPageChanged: (value) {
                          //  print('Page changed: $value');
                        },
                        autoPlayInterval: 3000,
                        isLoop: true,
                        children: homeProvider.bannerList.map((e) {
                          return e["bannerImage"].toString() != ""
                              ? Image.network(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  "${ApiConstant.baseUrl}/uploads/banners/" +
                                      e["bannerImage"],
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  noImage,
                                  fit: BoxFit.cover,
                                );
                        }).toList())
                    : const SizedBox(),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.to(() => const CategoryList());
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
                        Get.to(() =>  CategoryList(type: AppConstant.onTheWay,));
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
                              filter: {},
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                            height: 30,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Remote Search',
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: const Divider(
                color: grey,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              width: double.infinity,
              height: AppConstant.height(context) * 0.15,
              decoration: BoxDecoration(
                  color: grey.withOpacity(.1),
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: homeProvider.singleBannerList.isNotEmpty
                          ? NetworkImage(
                              homeProvider.singleBannerList.first["offerImage"])
                          : const NetworkImage(
                              "https://img.freepik.com/premium-vector/mega-sale-discount-banner-set-promotion-with-yellow-background_497837-702.jpg"))),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 10, bottom: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: homeProvider.bannerList.isNotEmpty
                    ? ImageSlideshow(
                        width: double.infinity,
                        height: 200,
                        initialPage: 0,
                        indicatorColor: primaryColor,
                        indicatorBackgroundColor: grey,
                        onPageChanged: (value) {
                          //  print('Page changed: $value');
                        },
                        autoPlayInterval: 3000,
                        isLoop: true,
                        children: homeProvider.bannerList.map((e) {
                          return e["bannerImage"].toString() != ""
                              ? Image.network(
                                  "${ApiConstant.baseUrl}/uploads/banners/" +
                                      e["bannerImage"],
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  noImage,
                                  fit: BoxFit.cover,
                                );
                        }).toList())
                    : const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
