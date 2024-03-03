import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuseme/constant/app_constants.dart';
import 'package:xuseme/provider/profile_provider.dart';
import 'package:xuseme/services/preference_services.dart';
import 'package:xuseme/view/widgets/custom_web_view.dart';

import '../../services/api_services.dart';
import '../../constant/color.dart';

class BySelf extends StatefulWidget {
  const BySelf({Key? key}) : super(key: key);

  @override
  State<BySelf> createState() => _BySelfState();
}

class _BySelfState extends State<BySelf> {
  String? dropdownValues;
  int selectedMonth = 1;

  XFile? upload;
  final ImagePicker _uploadImage = ImagePicker();

  uploadPhoto(ImageSource imageSource) async {
    await _uploadImage.pickImage(source: imageSource).then((value) {
      upload = value;
      setState(() {});
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final profileProvider = Provider.of<ProfileProvider>(context,listen: false);
    profileProvider.getPostCosting();

  }


  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    int postCosting = profileProvider.postCosting["bySelfPrice"]??0;
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          var trID = "${DateTime.now().millisecondsSinceEpoch}_${AppConstant.regId}";
          final prefs = await SharedPreferences.getInstance();



          prefs.setString("trId", trID).then((value) async {
            log("${profileProvider.profileData["mobile"]}");
            var value2 = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyWebViewScreen(
                        url: "https://xuseme.com/payment/?mobile=${profileProvider.profileData["mobile"]}&amount=${ postCosting* selectedMonth}"
                            "&order_id=$trID"
                            "&amount=${postCosting * selectedMonth}&order_id=$trID"
                            "&name=${profileProvider.profileData["name"]}"
                            "&address=${profileProvider.profileData["address"]}"
                            "&city=${profileProvider.profileData["city"]}"
                            "&pincode=${profileProvider.profileData["pincode"]}"
                            "&email=${profileProvider.profileData["email"]}"
                            "&state=${profileProvider.profileData["state"]}",
                      )),
            );
            log("NEW TRY ON DASH BOARD $value2");
            Fluttertoast.showToast(msg: "${value2["order_status"]}");
            if (value2["order_status"].toString().toUpperCase() != "SUCCESS") {
              Fluttertoast.showToast(msg: "Payment failed");
            } else if (value2["order_status"].toString().toUpperCase() == "SUCCESS") {
              if (upload?.path != null) {
                ApiServices().addBannerBySelf(PrefService().getRegId(), dropdownValues, upload!.path, "${postCosting * selectedMonth}").then((value) {
                  Fluttertoast.showToast(msg: "${value["message"]}", backgroundColor: primaryColor);
                });
                Navigator.pop(context);
              } else {
                Fluttertoast.showToast(msg: "Please Select Banner ");
              }
              Fluttertoast.showToast(msg: "Payment Successful");
            } else {
              Fluttertoast.showToast(msg: "Something went wrong");
            }
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          alignment: Alignment.center,
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(color: textBlack, borderRadius: BorderRadius.circular(15)),
          child: Text(
            "Pay",
            style: GoogleFonts.alice(color: textWhite, fontSize: 16, fontWeight: FontWeight.bold),
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
                enabledBorder: OutlineInputBorder(borderSide: const BorderSide(width: 1, color: textBlack), borderRadius: BorderRadius.circular(5)),
                focusedBorder: OutlineInputBorder(borderSide: const BorderSide(width: 1, color: textBlack), borderRadius: BorderRadius.circular(5)),
                hintText: 'Select Month',
                contentPadding: const EdgeInsets.only(left: 10, right: 10),
                suffixStyle: const TextStyle(color: textBlack, fontWeight: FontWeight.bold),
              ),
              value: dropdownValues,
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
                  dropdownValues = newStateId!;
                  selectedMonth = int.parse(newStateId);
                });
              },
            ),
          ),
          upload == null
              ? Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  height: MediaQuery.of(context).size.height * .25,
                  width: double.infinity,
                  decoration: BoxDecoration(border: Border.all(color: textBlack), borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            content: TextButton(
                                onPressed: () {
                                  uploadPhoto(ImageSource.camera);
                                },
                                child: Text(
                                  "From Camera",
                                  style: GoogleFonts.alice(color: textBlack, fontSize: 16, fontWeight: FontWeight.bold),
                                )),
                            title: TextButton(
                                onPressed: () {
                                  uploadPhoto(ImageSource.gallery);
                                },
                                child: Text(
                                  "From Gallery",
                                  style: GoogleFonts.alice(color: textBlack, fontSize: 16, fontWeight: FontWeight.bold),
                                )),
                          ),
                        );
                      },
                      child: Text(
                        "Choose Photo",
                        style: GoogleFonts.alice(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                )
              : Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  height: MediaQuery.of(context).size.height * .25,
                  width: double.infinity,
                  decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: FileImage(File(upload!.path)))),
                ),
          Text(
            "( 1280 pixels by 720 pixels )",
            style: GoogleFonts.alice(color: red, fontWeight: FontWeight.w400, fontSize: 16),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Row(
              children: [
                Text(
                  "Total Amount",
                  style: GoogleFonts.alice(color: textBlack, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 15,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  height: 35,
                  width: 100,
                  decoration: BoxDecoration(color: primary.withOpacity(.1), borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "₹ ${postCosting * selectedMonth}.00",
                    style: GoogleFonts.alice(color: textBlack, fontSize: 16, fontWeight: FontWeight.w600),
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
