import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constant/color.dart';
import '../category/category_details.dart';
class SearchProduct extends StatefulWidget {
  const SearchProduct({super.key});

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  final pinCodeController = TextEditingController();
  String? selectState;
  String? shopTypes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: btnColor,
        elevation: 0,
        title: Text("Remote Search",style: GoogleFonts.alice(color: textWhite,fontSize: 16,fontWeight: FontWeight.bold),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: TextFormField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: textBlack),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: textBlack),
                    borderRadius: BorderRadius.circular(10)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
                labelText: ('Enter City Name'),
                labelStyle: GoogleFonts.alice(),
                contentPadding: const EdgeInsets.only(top: 10, left: 20),
              ),
            ),
          ),
          // Container(
          //   padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
          //   child: TextFormField(
          //     controller: pinCodeController,
          //     onChanged: (v) {
          //       if (v.length >= 7) {
          //         pinCodeController.text = "";
          //         Fluttertoast.showToast(
          //             msg: "Only Required 6 digit",
          //             backgroundColor: btnColor);
          //       }
          //     },
          //     cursorColor: Colors.black,
          //     keyboardType: TextInputType.number,
          //     decoration: InputDecoration(
          //       focusedBorder: OutlineInputBorder(
          //           borderSide: const BorderSide(width: 1, color: textBlack),
          //           borderRadius: BorderRadius.circular(10)),
          //       enabledBorder: OutlineInputBorder(
          //           borderSide: const BorderSide(width: 1, color: textBlack),
          //           borderRadius: BorderRadius.circular(10)),
          //       border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(10)),
          //       labelText: ('Pin Code'),
          //       labelStyle: GoogleFonts.alice(),
          //       contentPadding: const EdgeInsets.only(top: 10, left: 20),
          //     ),
          //   ),
          // ),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: DropdownButtonFormField<String>(
              key: UniqueKey(),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: textBlack),
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: textBlack),
                    borderRadius: BorderRadius.circular(10)),
                labelText: 'Select State ',
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                labelStyle: GoogleFonts.alice(),
              ),
              value: selectState,
              items: const [
                DropdownMenuItem<String>(
                  value: "1",
                  child: Text("Cake shop"),
                ),
                DropdownMenuItem<String>(
                  value: "2",
                  child: Text("Mobile Center"),
                ),
                DropdownMenuItem<String>(
                  value: "3",
                  child: Text("Pet Shop"),
                ),
              ],
              onChanged: (String? newStateId) {},
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: DropdownButtonFormField<String>(
              key: UniqueKey(),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: textBlack),
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: textBlack),
                    borderRadius: BorderRadius.circular(10)),
                labelText: 'Shop Type ',
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                labelStyle: GoogleFonts.alice(),
              ),
              value: shopTypes,
              items: const [
                DropdownMenuItem<String>(
                  value: "1",
                  child: Text("Cake shop"),
                ),
                DropdownMenuItem<String>(
                  value: "2",
                  child: Text("Mobile Center"),
                ),
                DropdownMenuItem<String>(
                  value: "3",
                  child: Text("Pet Shop"),
                ),
              ],
              onChanged: (String? newStateId) {
                setState(() {
                  shopTypes = newStateId!;
                });
              },
            ),
          ),
          SizedBox(height:MediaQuery.of(context).size.height*.05 ,),
          GestureDetector(
            onTap:(){
              Get.to(const CategoryDetailsList());
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              height: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: textBlack, borderRadius: BorderRadius.circular(15)),
              child: Text(
                "Search",
                style: GoogleFonts.alice(
                    color: textWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
