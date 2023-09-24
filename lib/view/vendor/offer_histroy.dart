import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:xuseme/services/api_services.dart';
import 'package:xuseme/constant/api_constant.dart';
import 'package:xuseme/constant/image.dart';
import 'package:xuseme/provider/inquiry_provider.dart';

import '../../services/preference_services.dart';
import '../../constant/app_constants.dart';
import '../../constant/color.dart';

class OfferHistory extends StatefulWidget {
  const OfferHistory({Key? key}) : super(key: key);

  @override
  State<OfferHistory> createState() => _OfferHistoryState();
}

class _OfferHistoryState extends State<OfferHistory> {
  late InquiryProvider inquiryProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inquiryProvider = Provider.of<InquiryProvider>(context, listen: false);
    var p = PrefService().getRegId();
    inquiryProvider.getOfferAdHistory(p);
    log("message444444${inquiryProvider.offerAdHistoryList}");
  }

  @override
  Widget build(BuildContext context) {
    final inquiryProvider = Provider.of<InquiryProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Offer History",
            style: GoogleFonts.alice(
                color: textWhite, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        body: ListView.builder(
            itemCount: inquiryProvider.offerAdHistoryList.length,
            itemBuilder: (context, index) {
              var data = inquiryProvider.offerAdHistoryList[index];

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: primary.withOpacity(.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: AppConstant.height(context) * 0.17,
                          width: AppConstant.width(context) * 0.75,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(data['offerImage'] != ""
                                      ? "${ApiConstant.baseUrl}/uploads/banners/${data['offerImage']}"
                                      : noImage))),
                        ),
                        GestureDetector(
                          onTap: () {
                            ApiServices()
                                .deleteOffer(data['_id'])
                                .then((value) {
                              inquiryProvider.removeOfferItem(index);
                              Fluttertoast.showToast(
                                  msg: "${value["message"]}");
                            });
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                    Text(data['offer'] ?? "")
                  ],
                ),

                /*       child: Column(
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
          ),*/
              );
            }));
  }
}
