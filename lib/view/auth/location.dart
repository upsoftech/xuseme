import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:xuseme/constant/image.dart';
import '../../constant/color.dart';
import '../navigation/navigation_page.dart';
import 'manual_location.dart';
class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  LocationData? locationData;

  List<Placemark>? placeMark;
  void getPermission() async {
    if (await Permission.location.isGranted) {
      /// location get ///

      getLocation().then((value) =>Get.to(()=>const NavigationPage()));
    } else {
      /// permission request ///
      Permission.location.request();
    }
  }

  Future<void> getLocation() async {
    locationData = await loc.Location.instance.getLocation();
  }

  Future<void> allowLocation() async{
    if (locationData != null){
      placeMark = await placemarkFromCoordinates(
          locationData!.latitude!, locationData!.longitude!);
      log(placeMark.toString());
    }else{
      getLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor.withOpacity(0.9), textWhite],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: textBlack),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 15,top: 0),
                child: Text("What's your location ?",style: GoogleFonts.alice(fontSize: 25,fontWeight: FontWeight.bold,color: textBlack),),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15,top: 10),
                child: Text("We need your location to show available restaurants & products.",style: GoogleFonts.alice(fontSize: 16,),),
              ),
              const SizedBox(height:60,),
           Container(
             alignment: Alignment.center,
             child: Image.asset(map),
           ),
              const SizedBox(height:60,),
              GestureDetector(
                onTap:(){
                  getPermission();
                 //Get.to(const NavigationPage());
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 20,right: 20),
                  height: 40,
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: textBlack,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child:Text('Allow location access',style:GoogleFonts.alice(color: textWhite,fontWeight: FontWeight.bold,fontSize: 16),),
                ),
              ),
              const SizedBox(height: 20,),
            GestureDetector(
              onTap:(){
              Get.to(()=>const ManualLocation());
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 20,),
                child:
                Text('Enter Location Manually',
                  style:GoogleFonts.alice(color: textBlack,
                      fontWeight: FontWeight.bold,fontSize: 16),),
              ),
            )
            ],
          ),
        ),
      ),
    );
  }
}
