import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constant/color.dart';
import '../drawer/drawer_page.dart';
import 'add_address.dart';
class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPage(),
      bottomNavigationBar: GestureDetector(
        onTap:(){
          Get.to(const AddAddress());
        },
        child: Container(
          alignment: Alignment.center,
          height: 45,
          margin:const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
          width: double.infinity,
          decoration: BoxDecoration(
            color: textBlack,
            borderRadius: BorderRadius.circular(5)
          ),
          child:Text("Add Address",style:GoogleFonts.alice(color: textWhite,fontSize: 16,fontWeight: FontWeight.w600) ,),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: textBlack),
        elevation: 0,
        title: Text("Address",style:GoogleFonts.alice(color: textBlack,fontSize: 16) ,),
      ),
      body:ListView(
        children: [
          Container(
            margin:const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.only(left: 15,top: 10,right: 5,bottom: 5),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color:grey.withOpacity(.1))
              ],
              borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                   const Icon(Icons.business_center_sharp,color: grey,),
                    const SizedBox(width: 15,),
                    Text("Office",style:GoogleFonts.alice(color: textBlack,fontSize: 16) ,),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(left:40),
                    child: Text("Dlf 6 3rd Floor Moti nagar New delhi 111015 office No.311 near moti nagar metro station",style:GoogleFonts.alice(fontSize: 14, color: grey, fontWeight: FontWeight.bold) ,)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: (){},
                        icon: const Icon(Icons.edit,color: Colors.grey,)),
                    IconButton(onPressed: (){},
                        icon: const Icon(Icons.delete,color:location,))

                  ],
                )
              ],
            ),
          )

        ],
      ),
    );
  }
}
