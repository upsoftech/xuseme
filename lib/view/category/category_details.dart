import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xuseme/constant/color.dart';
import 'package:xuseme/constant/image.dart';

import '../../constant/app_constants.dart';

class CategoryDetailsList extends StatefulWidget {
  const CategoryDetailsList({Key? key}) : super(key: key);

  @override
  State<CategoryDetailsList> createState() => _CategoryDetailsListState();
}

class _CategoryDetailsListState extends State<CategoryDetailsList>
    with TickerProviderStateMixin {
  List images = [
    banner,
    services,
    window,
    hotel,
    ro,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: btnColor,
          elevation: 0,
          title: Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: TextFormField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: textWhite),
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: textWhite),
                      borderRadius: BorderRadius.circular(10)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: ('Search here'),
                  labelStyle: GoogleFonts.alice(color: textWhite),
                  contentPadding: const EdgeInsets.only(top: 10, left: 20),
                  suffixIcon: SizedBox(
                    width: AppConstants.width(context) * 0.3,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.search,
                              color: textWhite,
                            )),
                        const Text('|'),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.mic,
                              color: textWhite,
                            ))
                      ],
                    ),
                  )),
            ),
          ),
        ),
        body: ListView.builder(
            itemCount: images.length,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return Container(
                  padding: const EdgeInsets.all(5),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: primary.withOpacity(.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await showDialog(
                                  context: context,
                                  builder: (_) => const ImageDialog());
                            },
                            child: CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(images[index])),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Khan Chicken and meat Shop",
                                style: GoogleFonts.alice(
                                    color: textBlack,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              Text(
                                "Owner Name : Rahim",
                                style: GoogleFonts.alice(
                                    color: btnColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "My business Address:",
                        style: GoogleFonts.alice(
                            fontSize: 16,
                            color: btnColor,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "first floor room no -101,Noida City, Noida,110015",
                        style: GoogleFonts.alice(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "My Services:",
                        style: GoogleFonts.alice(
                            fontSize: 16,
                            color: btnColor,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "Chicken leg,full leg,Mutton,Boneless leg Chicken,Chicken Lollipop etc",
                        style: GoogleFonts.alice(fontSize: 16),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("10 KM Away",style:
                          GoogleFonts.alice(color: primary,
                              fontSize: 16,fontWeight: FontWeight.bold),),
                          Row(
                            children: [
                              Image.asset(
                                whatsapp,
                                height: 40,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const CircleAvatar(
                                  radius: 15,
                                  backgroundColor: primary,
                                  child: Icon(
                                    Icons.call,
                                    color: textWhite,
                                    size: 20,
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              const CircleAvatar(
                                  radius: 15,
                                  backgroundColor: primary,
                                  child: Icon(
                                    Icons.call,
                                    color: textWhite,
                                    size: 20,
                                  ))
                            ],
                          ),

                        ],
                      ),
                    ],
                  ));
            }
            )
    );
  }
}

class ImageDialog extends StatelessWidget {
  const ImageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: double.infinity,
        height: 250,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage(banner),
                fit: BoxFit.cover)),
      ),
    );
  }
}
