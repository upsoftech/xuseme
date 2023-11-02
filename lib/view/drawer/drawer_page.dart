import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuseme/constant/api_constant.dart';
import 'package:xuseme/constant/color.dart';
import 'package:xuseme/constant/image.dart';
import 'package:xuseme/view/auth/login_screen.dart';
import '../../provider/profile_provider.dart';

import '../../services/preference_services.dart';
import '../navigation/help_screen.dart';
import '../vendor/offer_histroy.dart';
import '../vendor/my_adds.dart';
import '../vendor/my_leads.dart';
import '../vendor/post_add.dart';
import '../vendor/publish_offer.dart';
import 'account/user_account.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key, this.page}) : super(key: key);
  final int? page;

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  late ProfileProvider profileProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    profileProvider.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    var data = profileProvider.profileData;
    return SafeArea(
      child: Drawer(
        width: 200,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(color: primaryColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PrefService().getSelectType() == "customer"?  CircleAvatar(
                      backgroundImage: NetworkImage(data["profileLogo"]!="" &&data["profileLogo"]!=null ?
                          ApiConstant.baseUrl+"uploads/"+data["profileLogo"]:
                          noImage),
                      radius: 50,
                    ):CircleAvatar(
                      backgroundImage: NetworkImage(data["shopLogo"]!="" &&data["shopLogo"]!=null ?
                      ApiConstant.baseUrl+"uploads/"+data["shopLogo"]:
                      noImage),
                      radius: 50,
                    ),
                    Text(
                      '${data["name"] ?? ""}',
                      style: GoogleFonts.alice(
                          color: textWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
            ListTile(
              onTap: () {
              Get.to(()=>const UserAccount());
              },
              leading: const Icon(
                Icons.person,
                color: primaryColor,
              ),
              title: Text(
                "Profile",
                style: GoogleFonts.alice(
                    color: textBlack,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ),
            data["type"] == "partner"
                ? ListTile(
                    onTap: () {
                    Get.to(()=>const MyLead());
                    },
                    leading: const Icon(
                      Icons.leaderboard_outlined,
                      color: primaryColor,
                    ),
                    title: Text(
                      "My Leads",
                      style: GoogleFonts.alice(
                          color: textBlack,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  )
                : SizedBox(),
            data["type"] == "partner"
                ? ListTile(
                    onTap: () {
                    Get.to(()=>const PostAdd());
                    },
                    leading: const Icon(
                      Icons.post_add,
                      color: primaryColor,
                    ),
                    title: Text(
                      "Post Premium Add",
                      style: GoogleFonts.alice(
                          color: textBlack,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  )
                : SizedBox(),
            data["type"] == "partner"
                ? ListTile(
                    onTap: () {
                    Get.to(()=>const MyAdds());
                    },
                    leading: const Icon(
                      Icons.add_chart,
                      color: primaryColor,
                    ),
                    title: Text(
                      "Add History",
                      style: GoogleFonts.alice(
                          color: textBlack,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  )
                : SizedBox(),
            data["type"] == "partner"
                ? ListTile(
                    onTap: () {
                    Get.to(()=>const PublishedOffer());
                    },
                    leading: const Icon(
                      Icons.local_offer_outlined,
                      color: primaryColor,
                    ),
                    title: Text(
                      "Publish Your Offer",
                      style: GoogleFonts.alice(
                          color: textBlack,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  )
                : SizedBox(),
            data["type"] == "partner"
                ? ListTile(
                    onTap: () {
                    Get.to(()=>const OfferHistory());
                    },
                    leading: const Icon(
                      Icons.history,
                      color: primaryColor,
                    ),
                    title: Text(
                      "Offer History",
                      style: GoogleFonts.alice(
                          color: textBlack,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  )
                : SizedBox(),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HelpScreen()));
              },
              leading: const Icon(
                Icons.help,
                color: primaryColor,
              ),
              title: Text(
                "Help & Support",
                style: GoogleFonts.alice(
                    color: textBlack,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ),
            ListTile(
              onTap: () {
                final dialog = RatingDialog(
                  initialRating: 1.0,
                  starSize: 25,
                  title: Text(
                    'Xuseme',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.alice(
                        color: textBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  message: Text(
                    'Tap a star to set your rating.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.alice(fontSize: 14),
                  ),
                  image: Image.asset(
                    splashImages,
                    height: 100,
                  ),
                  submitButtonText: 'Submit',
                  submitButtonTextStyle: const TextStyle(color: primaryColor),
                  commentHint: 'Write Comment',
                  onCancelled: () => print('cancelled'),
                  onSubmitted: (response) {
                    print(
                        'rating: ${response.rating}, comment: ${response.comment}');

                    if (response.rating < 3.0) {
                    } else {
                      //_rateAndReviewApp();
                    }
                  },
                );
                showDialog(
                  context: context,
                  barrierDismissible:
                      true, // set to false if you want to force a rating
                  builder: (context) => dialog,
                );
              },
              leading: const Icon(
                Icons.reviews_outlined,
                color: primaryColor,
              ),
              title: Text(
                "Review & Rating",
                style: GoogleFonts.alice(
                    color: textBlack,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ),
            ListTile(
              onTap: () {
                Share.share(
                    'https://play.google.com/store/apps/details?id.com.instructivetech.testapp');
              },
              leading: const Icon(
                Icons.share,
                color: primaryColor,
              ),
              title: Text(
                "App Share",
                style: GoogleFonts.alice(
                    color: textBlack,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ),
            ListTile(
              onTap: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                await pref.clear().then((value) {
                  Navigator.popUntil(context, (route) => route.isFirst);
                Get.to(()=>const LoginScreen());
                });
              },
              leading: const Icon(
                Icons.logout,
                color: primaryColor,
              ),
              title: Text(
                "Log Out",
                style: GoogleFonts.alice(
                    color: textBlack,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
