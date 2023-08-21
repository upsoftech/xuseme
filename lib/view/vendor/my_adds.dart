import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xuseme/constant/image.dart';

import '../../constant/color.dart';

class MyAdds extends StatefulWidget {
  const MyAdds({Key? key}) : super(key: key);

  @override
  State<MyAdds> createState() => _MyAddsState();
}

class _MyAddsState extends State<MyAdds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: btnColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "My Add",
          style: GoogleFonts.alice(
              color: textWhite, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: ListView.builder(
        itemCount: 5,
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
                        const CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(window),
                        ),
                        const SizedBox(width: 10,),
                        Text(
                          "Mithiles kumar",
                          style: GoogleFonts.alice(
                              color: textBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ],
                    ),

                    const Icon(
                      Icons.delete,
                      color: red,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
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
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "1234567895 ",
                      style: GoogleFonts.alice(color: textBlack, fontSize: 16),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      "Shop Name :",
                      style: GoogleFonts.alice(
                          color: textBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Chicken Meat Shop",
                      style: GoogleFonts.alice(color: textBlack, fontSize: 16),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      "Shop Type :",
                      style: GoogleFonts.alice(
                          color: textBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Chicken shop ",
                      style: GoogleFonts.alice(color: textBlack, fontSize: 16),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      "Services :",
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
                          "Chicken ,boneless Chicken,Mutton ",
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
