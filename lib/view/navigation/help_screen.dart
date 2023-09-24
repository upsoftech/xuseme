import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xuseme/services/api_services.dart';

import '../../services/preference_services.dart';
import '../../constant/color.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help & Support"),
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: grey)),
            child: TextFormField(
              maxLines: 5,
              controller: msgController,
              decoration: InputDecoration(
                  hintText: "Type query...", border: InputBorder.none),
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              onPressed: () {
                if (msgController.text.trim() != '') {
                  var regId = PrefService().getRegId();
                  ApiServices().addHelpSupport(
                    {"message": msgController.text.trim(), "regId": regId},
                  ).then((value) {
                    Fluttertoast.showToast(msg: value["message"].toString());
                    Navigator.pop(context);
                  });
                } else {
                  Fluttertoast.showToast(msg: "Please fill all the fields ");
                }
              },
              child: Text("Submit"))
        ],
      ),
    );
  }
}
