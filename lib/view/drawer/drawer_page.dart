import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuseme/constant/color.dart';
import 'package:xuseme/constant/image.dart';
import 'package:xuseme/view/login_screen.dart';
import '../../api_services/preference_services.dart';
import '../../provider/profile_provider.dart';
import '../../vendor/add_histroy.dart';
import '../../vendor/my_adds.dart';
import '../../vendor/my_leads.dart';
import '../../vendor/post_add.dart';
import '../../vendor/publish_offer.dart';
import '../user_account/user_account.dart';

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
    profileProvider=Provider.of<ProfileProvider>(context, listen: false);
    profileProvider.getProfile();
  }
  final PrefService _prefService=PrefService();
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    var data=profileProvider.profileData;
    return SafeArea(
      child: Drawer(
        width: 200,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(color: btnColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     CircleAvatar(
                      backgroundImage: NetworkImage(data["profileLogo"]??""),
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
                Get.to(const UserAccount());
              },
              leading: const Icon(
                Icons.person,
                color: btnColor,
              ),
              title: Text(
                "Profile",
                style: GoogleFonts.alice(
                    color: textBlack,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ),
            // ListTile(
            //   onTap: () {
            //    Get.to(const SettingPage());
            //   },
            //   leading: const Icon(
            //     Icons.settings,
            //     color: btnColor,
            //   ),
            //   title: Text(
            //     "Setting",
            //     style: GoogleFonts.alice(
            //         color: textBlack,
            //         fontWeight: FontWeight.w500,
            //         fontSize: 16),
            //   ),
            // ),
            ListTile(
              onTap: () {
                Get.to(const MyLead());
              },
              leading: const Icon(
                Icons.leaderboard_outlined,
                color: btnColor,
              ),

              title: Text(
                "My leads",
                style: GoogleFonts.alice(
                    color: textBlack,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ),

            ListTile(
              onTap: () {
                Get.to(const PostAdd());
              },
              leading: const Icon(
                Icons.post_add,
                color: btnColor,
              ),
              title: Text(
                "Post Add",
                style: GoogleFonts.alice(
                    color: textBlack,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ),

            ListTile(
              onTap: () {
                Get.to(const MyAdds());
              },
              leading: const Icon(
                Icons.add_chart,
                color: btnColor,
              ),
              title: Text(
                "My Adds",
                style: GoogleFonts.alice(
                    color: textBlack,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ),

            ListTile(
              onTap: () {
                Get.to(const PublishedOffer());
              },
              leading: const Icon(
                Icons.local_offer_outlined,
                color: btnColor,
              ),
              title: Text(
                "Published Offer",
                style: GoogleFonts.alice(
                    color: textBlack,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ),
            ListTile(
              onTap: () {
                Get.to(const AddHistory());
              },
              leading: const Icon(
                Icons.history,
                color: btnColor,
              ),
              title: Text(
                "Add History",
                style: GoogleFonts.alice(
                    color: textBlack,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(
                Icons.help,
                color: btnColor,
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
                  submitButtonTextStyle: const TextStyle(color: btnColor),
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
                color: btnColor,
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
                color: btnColor,
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
                 Get.to(const LoginScreen());
                });
              },
              leading: const Icon(
                Icons.logout,
                color: btnColor,
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
