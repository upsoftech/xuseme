import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:xuseme/constant/image.dart';

import '../../constant/api_constant.dart';
import '../../constant/color.dart';
import '../../provider/inquiry_provider.dart';
import '../../services/api_services.dart';

class MyAdds extends StatefulWidget {
  const MyAdds({Key? key}) : super(key: key);

  @override
  State<MyAdds> createState() => _MyAddsState();
}

class _MyAddsState extends State<MyAdds> {
  late InquiryProvider inquiryProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inquiryProvider = Provider.of<InquiryProvider>(context, listen: false);
    inquiryProvider.bannerHistory();
    // log("message${inquiryProvider.bannerHistoryList.first.bannerImage}");
  }

  @override
  Widget build(BuildContext context) {
    final inquiryProvider = Provider.of<InquiryProvider>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "My Add",
          style: GoogleFonts.alice(
              color: textWhite, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: ListView.builder(
        itemCount: inquiryProvider.bannerHistoryList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: const EdgeInsets.all(5),
            width: double.infinity,
            decoration: BoxDecoration(
                color: primary.withOpacity(.1),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(inquiryProvider
                                          .bannerHistoryList[index]
                                          .bannerImage !=
                                      "" &&
                                  inquiryProvider.bannerHistoryList[index]
                                          .bannerImage !=
                                      null
                              ? ApiConstant.baseUrl +
                                  "uploads/banners/" +
                                  inquiryProvider
                                      .bannerHistoryList[index].bannerImage
                                      .toString()
                              : noImage),
                          radius: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),

                      ],
                    ),
                    InkWell(
                      onTap: (){
                        ApiServices()
                            .deletePremiumAd( inquiryProvider
                            .bannerHistoryList[index].id.toString())
                            .then((value) {
                          inquiryProvider.removePremiumAdItem(index);
                          Fluttertoast.showToast(
                              msg: "${value["message"]}");
                        });
                      },
                      child: const Icon(
                        Icons.delete,
                        color: red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),



                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      "Validity :",
                      style: GoogleFonts.alice(
                          color: textBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * .7,
                        child: Text(
                          "${inquiryProvider
                              .bannerHistoryList[index]
                              .validity} Month ",
                          style:
                              GoogleFonts.alice(color: textBlack, fontSize: 16),
                        ))
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
