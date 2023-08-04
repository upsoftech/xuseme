import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xuseme/constant/image.dart';
import 'package:xuseme/view/screen/manual_lacation.dart';

import '../../constant/color.dart';
class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [btnColor.withOpacity(0.9), textWhite],
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
              Container(
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
              const SizedBox(height: 20,),
            GestureDetector(
              onTap:(){
                Get.to(const ManualLocation());
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
