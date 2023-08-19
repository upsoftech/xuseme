import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:xuseme/api_services/api_services.dart';
import 'package:xuseme/constant/color.dart';
import 'package:xuseme/constant/image.dart';
import '../../provider/inquiry_provider.dart';

class InquiryPage extends StatefulWidget {
  const InquiryPage({
    Key? key,
    // required this.data,
  }) : super(key: key);
  // final InquiryModel data;

  @override
  State<InquiryPage> createState() => _InquiryPageState();
}

class _InquiryPageState extends State<InquiryPage> {
  late InquiryProvider inquiryProvider;
  @override
  void initState() {
    super.initState();
    inquiryProvider = Provider.of<InquiryProvider>(context, listen: false);
    inquiryProvider.inquiryData("cold");
  }

  @override
  Widget build(BuildContext context) {
    inquiryProvider = Provider.of<InquiryProvider>(
      context,
    );
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: btnColor,
          elevation: 0,
          title: Text(
            "Inquiry",
            style: GoogleFonts.alice(color: textWhite, fontSize: 16),
          ),
        ),
        body: Center(
          child: inquiryProvider.isLoading
              ? const CircularProgressIndicator(
                  color: btnColor,
                )
              : inquiryProvider.inquiryList.isEmpty
                  ? Center(
                      child: Text(
                        "No Data Found",
                        style: GoogleFonts.alice(
                            color: btnColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  : ListView.builder(
                      itemCount: inquiryProvider.inquiryList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: primary.withOpacity(.05),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: primary.withOpacity(.1),
                                    //color: boxColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.network(
                                    /*inquiryProvider
                                .inquiryList[index].partnerInfo?.profileLogo ??*/
                                    noImage,
                                    width: 90,
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .55,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      inquiryProvider.inquiryList[index]
                                              .partnerInfo?.shopName ??
                                          "",
                                      style: GoogleFonts.alice(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(inquiryProvider.inquiryList[index]
                                            .partnerInfo?.services ??
                                        ""),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                        "${inquiryProvider.inquiryList[index].partnerInfo?.address ?? ""} ${inquiryProvider.inquiryList[index].partnerInfo?.landmark ?? ""} ${inquiryProvider.inquiryList[index].partnerInfo?.pincode ?? ""} ${inquiryProvider.inquiryList[index].partnerInfo?.state ?? ""}"),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(inquiryProvider.inquiryList[index]
                                            .partnerInfo?.createdAt ??
                                        "")
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  ApiServices().callInquiry({
                                    "customerId": inquiryProvider
                                            .inquiryList[index]
                                            .customerInfo
                                            ?.id ??
                                        "",
                                    "partnerId": inquiryProvider
                                            .inquiryList[index]
                                            .partnerInfo
                                            ?.id ??
                                        "",
                                    "type":"warm"
                                  }).then((value) {
                                    Fluttertoast.showToast(
                                        msg: "$value",
                                        backgroundColor: btnColor);
                                  });
                                },
                                child: Container(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: const Icon(
                                      Icons.call,
                                      size: 25,
                                      color: primary,
                                    )),
                              )
                            ],
                          ),
                        );
                      }),
        )
    );
  }
}
