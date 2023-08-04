import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constant/color.dart';
import 'navigation_page.dart';
class ManualLocation extends StatefulWidget {
  const ManualLocation({Key? key}) : super(key: key);

  @override
  State<ManualLocation> createState() => _ManualLocationState();
}

class _ManualLocationState extends State<ManualLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: textBlack),
        elevation: 0,
        title: Text('Enter Your Location or apartment name',style: GoogleFonts.alice(fontSize: 16),),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  labelText: ('Enter Location'),
                  labelStyle: GoogleFonts.alice(),
                  contentPadding: const EdgeInsets.only(top: 10, left: 20),
                  prefixIcon:IconButton(onPressed:(){},
                      icon: const Icon(Icons.search_outlined,color: textBlack,))
                ),
              ),
            ),
           GestureDetector(
             onTap:(){
               Get.to(const NavigationPage());
             },
             child:  Container(
               padding: const EdgeInsets.only(left: 10,top: 15),
               child: Row(
                 children: [
                   const Icon(Icons.location_on_rounded,color:location,),
                   const SizedBox(width: 15,),
                   Text('Use my current location',
                     style:GoogleFonts.alice(color: textBlack, fontWeight: FontWeight.bold,fontSize: 16),),
                 ],
               ),
             ),
           )
          ],
        ),
      ),
    );
  }
}
