import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:xuseme/constant/api_constant.dart';
import 'package:xuseme/constant/image.dart';
import 'package:xuseme/provider/home_provider.dart';
import 'package:xuseme/provider/location_provider.dart';
import 'package:xuseme/view/home/remote_search.dart';
import '../../constant/app_constants.dart';
import '../../constant/color.dart';
import '../category/food_list.dart';
import '../drawer/drawer_page.dart';
import '../user_account/user_account.dart';

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
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.getBanner();
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(
      context,
    );

    return Scaffold(
      drawer: const DrawerPage(),
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: btnColor,
          elevation: 0,
          title: ListTile(
            trailing: GestureDetector(
              onTap: () {
                Get.to(const UserAccount());
              },
              child: Image.asset(user),
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
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: homeProvider.bannerList.isNotEmpty
                    ? ImageSlideshow(
                        width: double.infinity,
                        height: 200,
                        initialPage: 0,
                        indicatorColor: btnColor,
                        indicatorBackgroundColor: grey,
                        onPageChanged: (value) {
                          //  print('Page changed: $value');
                        },
                        autoPlayInterval: 3000,
                        isLoop: true,
                        children: homeProvider.bannerList.map((e) {
                          return e["bannerImage"].toString() == ""
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
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.to(const FoodList());
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
                        Get.to(const FoodList());
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
                            'Shopkeepers\non the way',
                            style: GoogleFonts.salsa(
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      )),
                  GestureDetector(
                      onTap: () {
                        Get.to(const FoodList());
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                        Get.to(const SearchProduct());
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
                        Get.to(const UserAccount());
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
                        Get.to(const FoodList());
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
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                  color: grey.withOpacity(.1),
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: Text(
                  'Swiggy\nOne',
                  style: GoogleFonts.salsa(fontSize: 16, color: btnColor),
                ),
                trailing: Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                      color: btnColor, borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Buy Now',
                    style: GoogleFonts.salsa(fontSize: 16, color: textWhite),
                  ),
                ),
                title: Text.rich(TextSpan(
                    text: 'Pay  ',
                    style: GoogleFonts.alice(fontSize: 16),
                    children: <InlineSpan>[
                      TextSpan(
                        text: '₹ 0 delivery fee ',
                        style: GoogleFonts.alice(fontSize: 16, color: btnColor),
                      ),
                      TextSpan(
                          text: 'on ', style: GoogleFonts.alice(fontSize: 16)),
                      TextSpan(
                          text: 'food Get one @341/month ',
                          style: GoogleFonts.alice(fontSize: 16)),
                    ])),
              ),
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
                        indicatorColor: btnColor,
                        indicatorBackgroundColor: grey,
                        onPageChanged: (value) {
                          //  print('Page changed: $value');
                        },
                        autoPlayInterval: 3000,
                        isLoop: true,
                        children: homeProvider.bannerList.map((e) {
                          return e["bannerImage"].toString() == ""
                              ? Image.network(
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
