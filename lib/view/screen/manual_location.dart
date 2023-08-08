import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart' as locate;
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../constant/color.dart';
import 'navigation_page.dart';

class ManualLocation extends StatefulWidget {
  const ManualLocation({Key? key}) : super(key: key);

  @override
  State<ManualLocation> createState() => _ManualLocationState();
}
LocationData? locationData;
class _ManualLocationState extends State<ManualLocation> {

  final locationAddress = TextEditingController();

  List<Placemark>? placeMark;
  void getPermissions() async {
    if (await Permission.location.isGranted) {
      /// location get ///

      getLocations();
    } else {
      /// permission request ///
      Permission.location.request();
    }
  }

  void getLocations() async {
    locationData = await locate.Location.instance.getLocation();
  }

  void getLocationAddress() async {
    // log(placeMark.toString());

    if (locationData != null) {
      placeMark = await placemarkFromCoordinates(
          locationData!.latitude!, locationData!.longitude!);
      log(placeMark.toString());

      locationAddress.text =
          "${placeMark!.first.subThoroughfare.toString()} ${placeMark!.first.subLocality.toString()} ${placeMark!.first.street.toString()} "
          " ${placeMark!.first.subAdministrativeArea.toString()} ${placeMark!.first.thoroughfare.toString()} ${placeMark!.first.locality.toString()} ${placeMark!.first.postalCode.toString()}";
      setState(() {});
    } else {
      getLocations();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Get.to(const NavigationPage());
        },
        child: Container(
          height: 45,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
            color: textBlack,
            borderRadius: BorderRadius.circular(10)
          ),
          alignment: Alignment.center,
          child: Text(
            "Next",
            style: GoogleFonts.alice(
                color: textWhite, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: textBlack),
        elevation: 0,
        title: Text(
          'Enter Your Location or apartment name',
          style: GoogleFonts.alice(fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: TextFormField(
                controller: locationAddress,
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
                    labelText: ('Enter Location'),
                    labelStyle: GoogleFonts.alice(),
                    contentPadding: const EdgeInsets.only(top: 10, left: 20),
                    prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search_outlined,
                          color: textBlack,
                        ))),
              ),
            ),
            GestureDetector(
              onTap: () {
                getLocationAddress();
              },
              child: Container(
                padding: const EdgeInsets.only(left: 10, top: 15),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Use my current location',
                      style: GoogleFonts.alice(
                          color: textBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
