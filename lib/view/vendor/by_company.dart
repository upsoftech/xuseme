import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api_services/api_services.dart';
import '../../api_services/preference_services.dart';
import '../../constant/color.dart';

class ByCompany extends StatefulWidget {
  const ByCompany({Key? key}) : super(key: key);

  @override
  State<ByCompany> createState() => _ByCompanyState();
}

class _ByCompanyState extends State<ByCompany> {
  String? dropdownValues1;
  int selectedMonths = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () {
          ApiServices()
              .addBannerByCompany(PrefService().getRegId(), dropdownValues1,
                  "${100 * selectedMonths}")
              .then((value) {
            Fluttertoast.showToast(
                msg: "${value["message"]}", backgroundColor: btnColor);
            Navigator.pop(context);
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          alignment: Alignment.center,
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
              color: textBlack, borderRadius: BorderRadius.circular(15)),
          child: Text(
            "Pay",
            style: GoogleFonts.alice(
                color: textWhite, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: DropdownButtonFormField<String>(
              key: UniqueKey(),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: textBlack),
                    borderRadius: BorderRadius.circular(5)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: textBlack),
                    borderRadius: BorderRadius.circular(5)),
                hintText: 'Select Month',
                contentPadding: const EdgeInsets.only(left: 10, right: 10),
                suffixStyle: const TextStyle(
                    color: textBlack, fontWeight: FontWeight.bold),
              ),
              value: dropdownValues1,
              items: const [
                DropdownMenuItem<String>(
                  value: "1",
                  child: Text("One Month"),
                ),
                DropdownMenuItem<String>(
                  value: "2",
                  child: Text("Two Month"),
                ),
                DropdownMenuItem<String>(
                  value: "3",
                  child: Text("Three Month"),
                ),
                DropdownMenuItem<String>(
                  value: "4",
                  child: Text("Four Month"),
                ),
                DropdownMenuItem<String>(
                  value: "5",
                  child: Text("Five Month"),
                ),
                DropdownMenuItem<String>(
                  value: "6",
                  child: Text("Six Month"),
                ),
                DropdownMenuItem<String>(
                  value: "7",
                  child: Text("Seven Month"),
                ),
                DropdownMenuItem<String>(
                  value: "8",
                  child: Text("Eight Month"),
                ),
                DropdownMenuItem<String>(
                  value: "9",
                  child: Text("Nine Month"),
                ),
                DropdownMenuItem<String>(
                  value: "10",
                  child: Text("Ten Month"),
                ),
                DropdownMenuItem<String>(
                  value: "11",
                  child: Text("Eleven Month"),
                ),
                DropdownMenuItem<String>(
                  value: "12",
                  child: Text("Twelve Month"),
                ),
              ],
              onChanged: (String? newStateId) {
                setState(() {
                  dropdownValues1 = newStateId!;
                  selectedMonths = int.parse(newStateId);
                });
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Row(
              children: [
                Text(
                  "Total Amount",
                  style: GoogleFonts.alice(
                      color: textBlack,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 15,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  height: 35,
                  width: 100,
                  decoration: BoxDecoration(
                      color: primary.withOpacity(.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "₹ ${200 * selectedMonths}.00",
                    style: GoogleFonts.alice(
                        color: textBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
