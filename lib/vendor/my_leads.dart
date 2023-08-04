import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xuseme/constant/color.dart';

class MyLead extends StatefulWidget {
  const MyLead({Key? key}) : super(key: key);

  @override
  State<MyLead> createState() => _MyLeadState();
}

class _MyLeadState extends State<MyLead> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: btnColor,
        centerTitle: true,
        title: Text(
          "My Leads",
          style: GoogleFonts.alice(
              color: textWhite, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: ListView.builder(
          itemCount: 5,
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
                        "Rehan Ali Khan",
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
                        "1234567890",
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
                        "10/12/2023",
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
                        "10:00 AM",
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
