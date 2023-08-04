import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xuseme/constant/app_constants.dart';

import '../../constant/color.dart';
class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  String address = 'Home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        height: 45,
        margin:const EdgeInsets.symmetric(horizontal: 15),
        width: double.infinity,
        decoration: BoxDecoration(
            color: textBlack,
            borderRadius: BorderRadius.circular(5)
        ),
        child:Text("Submit",style:GoogleFonts.alice(color: textWhite,fontSize: 16,fontWeight: FontWeight.w600) ,),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: textBlack),
        elevation: 0,
        title: Text("Add Address",style:GoogleFonts.alice(color: textBlack,fontSize: 16) ,),
      ),
      body:ListView(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: TextFormField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(width: 1, color:textBlack),
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(width: 1, color:textBlack),
                      borderRadius: BorderRadius.circular(10)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: ('House/Flat/Block'),
                  hintStyle: GoogleFonts.alice(),
                  contentPadding: const EdgeInsets.only(top: 10, left: 20),

              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: TextFormField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(width: 1, color:textBlack),
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(width: 1, color:textBlack),
                      borderRadius: BorderRadius.circular(10)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: ('Apartment/Road/Area'),
                  hintStyle: GoogleFonts.alice(),
                  contentPadding: const EdgeInsets.only(top: 10, left: 20),

              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: TextFormField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(width: 1, color:textBlack),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(width: 1, color:textBlack),
                    borderRadius: BorderRadius.circular(10)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
                hintText: ('Pin Code'),
                hintStyle: GoogleFonts.alice(),
                contentPadding: const EdgeInsets.only(top: 10, left: 20),

              ),
            ),
          ),
          const SizedBox(height: 15,),
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
            trailing: SizedBox(width: AppConstants.width(context)*0.35,),
            title:  Container(
              alignment: Alignment.center,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: grey),
                  borderRadius: BorderRadius.circular(10)
              ),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.work,color:btnColor,),
                  Text("Work",style:GoogleFonts.alice(color: textBlack,fontSize: 16,fontWeight: FontWeight.w600) ,)
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
           trailing: SizedBox(width: AppConstants.width(context)*0.35,),
            title: Container(
              alignment: Alignment.center,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: grey),
                  borderRadius: BorderRadius.circular(10)
              ),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.home,color:btnColor,),
                  Text("Home",style:GoogleFonts.alice(color: textBlack,fontSize: 16,fontWeight: FontWeight.w600) ,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
