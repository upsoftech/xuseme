import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:xuseme/provider/inquiry_provider.dart';

import '../constant/color.dart';
import '../utils/utility.dart';

class AddHistory extends StatefulWidget {
  const AddHistory({Key? key}) : super(key: key);

  @override
  State<AddHistory> createState() => _AddHistoryState();
}

class _AddHistoryState extends State<AddHistory> {

  late InquiryProvider inquiryProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inquiryProvider=Provider.of<InquiryProvider>(context, listen: false);
    inquiryProvider.bannerHistory();
  }
  @override
  Widget build(BuildContext context) {
    final inquiryProvider=Provider.of<InquiryProvider>(context,);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: btnColor,
        elevation: 0,
        centerTitle: true,
        title: Text("Post Add History",style: GoogleFonts.alice(color: textWhite,fontWeight: FontWeight.bold,fontSize: 16),),
      ),
      body:ListView.builder(
        itemCount: inquiryProvider.bannerHistoryList.length,
          itemBuilder: (context,index){
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
                  Text("${index+1}",style: GoogleFonts.alice(fontSize: 16),),
                ],
              ),
              Row(
                children: [
                  Text("Amount :",style: GoogleFonts.alice(color: textBlack,fontWeight: FontWeight.w600,fontSize: 16),),
                  SizedBox(width: MediaQuery.of(context).size.width*.095,),
                  Text("₹ ${inquiryProvider.bannerHistoryList[index].price??""}",style: GoogleFonts.alice(fontSize: 16),),
                ],
              ),
              Row(
                children: [
                  Text("Trans. ID :",style: GoogleFonts.alice(color: textBlack,fontWeight: FontWeight.w600,fontSize: 16),),
                  SizedBox(width: MediaQuery.of(context).size.width*.08,),
                  Text(inquiryProvider.bannerHistoryList[index].transactionId??"",style: GoogleFonts.alice(fontSize: 16),),
                ],
              ),
              Row(
                children: [
                  Text("Time :",style: GoogleFonts.alice(color: textBlack,fontWeight: FontWeight.w600,fontSize: 16),),
                  SizedBox(width: MediaQuery.of(context).size.width*.16,),
                  Text(Utility.formatMongoDateAndTime(inquiryProvider.bannerHistoryList[index].updatedAt ??"2023-08-17T12:34:56.789Z"),style: GoogleFonts.alice(fontSize: 16),),
                ],
              ),
            ],
          ),
        );
      })
    );
  }
}
