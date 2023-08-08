import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../api_services/preference_services.dart';
import '../../constant/color.dart';
import '../../provider/profile_provider.dart';
import '../drawer/drawer_page.dart';
import 'add_address.dart';
class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  late ProfileProvider profileProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileProvider= Provider.of<ProfileProvider>(context, listen: false);
    profileProvider.getAddress();
  }
  @override
  Widget build(BuildContext context) {
    Provider.of<ProfileProvider>(context);


    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap:(){
          Get.to( const AddAddress(isEdit: false,));
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
      body:Consumer<ProfileProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.addressList.length,
            itemBuilder: (
                BuildContext context, i)
            {
              var e = value.addressList[i];
              return Container(
                margin:const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
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
                        child: Text(
                       " ${e.address.toString()} ${e.landmark} ${e.state} ${e.pincode}",style:GoogleFonts.alice(fontSize: 14, color: grey, fontWeight: FontWeight.bold) ,)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(onPressed: (){
                          var regIds = PrefService().getRegId();
                          Get.to( AddAddress(isEdit: true,data:
                          e
                          ,));
                        },
                            icon: const Icon(Icons.edit,color: Colors.grey,)),
                        IconButton(onPressed: (){},
                            icon: const Icon(Icons.delete,color:red,))

                      ],
                    )
                  ],
                ),
              );
            },

          );
        }
      ),
    );
  }
}
