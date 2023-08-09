import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:xuseme/constant/app_constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../api_services/api_services.dart';
import '../../api_services/preference_services.dart';
import '../../constant/color.dart';
import '../../model/address_model.dart';
import '../../provider/profile_provider.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key, this.data, required this.isEdit})
      : super(key: key);
  final AddressModel? data;
  final bool isEdit;
  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  String address = 'Home';
  final houseController = TextEditingController();
  final apartController = TextEditingController();
  final stateController = TextEditingController();
  final pinController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isEdit) {
      houseController.text = widget.data!.address.toString();
      apartController.text = widget.data!.landmark.toString();
      stateController.text = widget.data!.state.toString();
      pinController.text = widget.data!.pincode.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    log("check ${widget.data?.id}");

    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if (!widget.isEdit) {
            var regIds = PrefService().getRegId();
            ApiServices().updateUserAddress({
              "userId": regIds,
              "address": houseController.text.trim(),
              "landmark": apartController.text.trim(),
              "state": stateController.text.trim(),
              "pincode": pinController.text.trim(),
            }).then((value) {
              Fluttertoast.showToast(msg: "$value");
              Provider.of<ProfileProvider>(context, listen: false).getAddress();
              Get.back();
            });
          } else {
            ApiServices().updateAddress(widget.data!.id.toString(), {
              "address": houseController.text.trim(),
              "landmark": apartController.text.trim(),
              "pincode": pinController.text.trim(),
              "state": stateController.text.trim()
            }).then((value) {
              log(value.toString());
              Provider.of<ProfileProvider>(context, listen: false).getAddress();
              Get.back();
            });
          }
        },
        child: Container(
          alignment: Alignment.center,
          height: 45,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          width: double.infinity,
          decoration: BoxDecoration(
              color: textBlack, borderRadius: BorderRadius.circular(5)),
          child: Text(
            "Submit",
            style: GoogleFonts.alice(
                color: textWhite, fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: btnColor,
        elevation: 0,
        title: Text(
          "${widget.isEdit ? "Edit" : "Add"} Address",
          style: GoogleFonts.alice(color: textWhite, fontSize: 16,fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: TextFormField(
              controller: houseController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: textBlack),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: textBlack),
                    borderRadius: BorderRadius.circular(10)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: ('House/Flat/Block'),
                hintStyle: GoogleFonts.alice(),
                contentPadding: const EdgeInsets.only(top: 10, left: 20),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: TextFormField(
              controller: apartController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: textBlack),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: textBlack),
                    borderRadius: BorderRadius.circular(10)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: ('Apartment/Road/Area'),
                hintStyle: GoogleFonts.alice(),
                contentPadding: const EdgeInsets.only(top: 10, left: 20),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: TextFormField(
              controller: stateController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: textBlack),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: textBlack),
                    borderRadius: BorderRadius.circular(10)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: ('State'),
                hintStyle: GoogleFonts.alice(),
                contentPadding: const EdgeInsets.only(top: 10, left: 20),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: pinController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: textBlack),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: textBlack),
                    borderRadius: BorderRadius.circular(10)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: ('Pin Code'),
                hintStyle: GoogleFonts.alice(),
                contentPadding: const EdgeInsets.only(top: 10, left: 20),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ListTile(
            leading: Radio<String>(
              activeColor: btnColor,
              value: 'Work',
              groupValue: address,
              onChanged: (value) {
                setState(() {
                  address = value!;
                });
              },
            ),
            trailing: SizedBox(
              width: AppConstants.width(context) * 0.35,
            ),
            title: Container(
              alignment: Alignment.center,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: grey),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    Icons.work,
                    color: btnColor,
                  ),
                  Text(
                    "Work",
                    style: GoogleFonts.alice(
                        color: textBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            leading: Radio<String>(
              activeColor: btnColor,
              value: 'Home',
              groupValue: address,
              onChanged: (value) {
                setState(() {
                  address = value!;
                });
              },
            ),
            trailing: SizedBox(
              width: AppConstants.width(context) * 0.35,
            ),
            title: Container(
              alignment: Alignment.center,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: grey),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    Icons.home,
                    color: btnColor,
                  ),
                  Text(
                    "Home",
                    style: GoogleFonts.alice(
                        color: textBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
