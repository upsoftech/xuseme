import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/color.dart';

class AddHistory extends StatefulWidget {
  const AddHistory({Key? key}) : super(key: key);

  @override
  State<AddHistory> createState() => _AddHistoryState();
}

class _AddHistoryState extends State<AddHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: btnColor,
        elevation: 0,
        centerTitle: true,
        title: Text("Post Add History",style: GoogleFonts.alice(color: textWhite,fontWeight: FontWeight.bold,fontSize: 16),),
      ),
      body:ListView.builder(itemBuilder: (context,index){
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: primary.withOpacity(.1),
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text("Sr.No :",style: GoogleFonts.alice(color: textBlack,fontWeight: FontWeight.w600,fontSize: 16),),
                  SizedBox(width: MediaQuery.of(context).size.width*.15,),
                  Text("1",style: GoogleFonts.alice(fontSize: 16),),
                ],
              ),
              Row(
                children: [
                  Text("Amount :",style: GoogleFonts.alice(color: textBlack,fontWeight: FontWeight.w600,fontSize: 16),),
                  SizedBox(width: MediaQuery.of(context).size.width*.095,),
                  Text("₹ 140.00",style: GoogleFonts.alice(fontSize: 16),),
                ],
              ),
              Row(
                children: [
                  Text("Trans. ID :",style: GoogleFonts.alice(color: textBlack,fontWeight: FontWeight.w600,fontSize: 16),),
                  SizedBox(width: MediaQuery.of(context).size.width*.08,),
                  Text("1401Anhh00",style: GoogleFonts.alice(fontSize: 16),),
                ],
              ),
              Row(
                children: [
                  Text("Time :",style: GoogleFonts.alice(color: textBlack,fontWeight: FontWeight.w600,fontSize: 16),),
                  SizedBox(width: MediaQuery.of(context).size.width*.16,),
                  Text("1 June 2023,10:00 PM",style: GoogleFonts.alice(fontSize: 16),),
                ],
              ),
            ],
          ),
        );
      })
    );
  }
}
