import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:xuseme/constant/color.dart';

import '../../provider/inquiry_provider.dart';
import '../../utils/utility.dart';


class MyLead extends StatefulWidget {
  const MyLead({Key? key}) : super(key: key);

  @override
  State<MyLead> createState() => _MyLeadState();
}

class _MyLeadState extends State<MyLead> {
  late InquiryProvider inquiryProvider;
  @override
  void initState() {
    super.initState();
    inquiryProvider = Provider.of<InquiryProvider>(context, listen: false);
    inquiryProvider.inquiryData("warm"); //hot
  }
  @override
  Widget build(BuildContext context) {
    final inquiryProvider = Provider.of<InquiryProvider>(context,);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          "My Leads",
          style: GoogleFonts.alice(
              color: textWhite, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: ListView.builder(
          itemCount: inquiryProvider.inquiryList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              padding: const EdgeInsets.only(left: 15, bottom: 5, top: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: primary.withOpacity(.1),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        "Name :",
                        style: GoogleFonts.alice(
                            color: textBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .1,
                      ),
                      Text(
                        inquiryProvider.inquiryList[index].customerInfo?.name??"",
                        style:
                            GoogleFonts.alice(color: textBlack, fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Mobile No :",
                        style: GoogleFonts.alice(
                            color: textBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .02,
                      ),
                      Text(
                        inquiryProvider.inquiryList[index].customerInfo?.mobile??"",
                        style:
                            GoogleFonts.alice(color: textBlack, fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Date :",
                        style: GoogleFonts.alice(
                            color: textBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .123,
                      ),
                      Text(
                        Utility.formatMongoDate(inquiryProvider.inquiryList[index].customerInfo?.updatedAt ??"2023-08-17T12:34:56.789Z")   ,


                        style:
                            GoogleFonts.alice(color: textBlack, fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Time :",
                        style: GoogleFonts.alice(
                            color: textBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .117,
                      ),
                      Text(
                        Utility.formatMongoTime(inquiryProvider.inquiryList[index].customerInfo?.updatedAt ??"2023-08-17T12:34:56.789Z")   ,


                        style:
                            GoogleFonts.alice(color: textBlack, fontSize: 16),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .32,
                      ),
                      const CircleAvatar(
                          radius: 20,
                          backgroundColor: primary,
                          child: Icon(
                            Icons.call,
                            color: textWhite,
                            size: 20,
                          )),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
