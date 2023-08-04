import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constant/color.dart';
import 'address_page.dart';
import 'edit_profile.dart';
import 'inquiry_page.dart';
class UserAccount extends StatefulWidget {
  const UserAccount({Key? key}) : super(key: key);

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: textBlack),
          elevation: 0,
        title: Text("Profile",style:GoogleFonts.alice(color: textBlack,fontSize: 16) ,),

      ),
      body:ListView(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.only(left:15,right: 15,top: 10,bottom: 10),
            decoration: BoxDecoration(
             // border: Border.all(color: grey),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 1,
                )
              ],
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Rehan Kumar",style: GoogleFonts.alice(fontSize: 18, color: textBlack, fontWeight: FontWeight.bold),),
                    GestureDetector(
                      onTap:(){
                        Get.to(const EditProfile());
                      },
                        child: Text("Edit",style: GoogleFonts.alice(fontSize: 20, color: secondry, fontWeight: FontWeight.bold),))
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.01,),
                Row(
                  children: [
                    Text("Mobile No.",style: GoogleFonts.alice(fontSize: 14, color: grey, fontWeight: FontWeight.bold),),
                    SizedBox(width: MediaQuery.of(context).size.width*.1,),
                    Text("1234567890",style: GoogleFonts.alice(fontSize: 14, color: grey, fontWeight: FontWeight.bold),)
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.01,),
                Row(
                  children: [
                    Text("Email",style: GoogleFonts.alice(fontSize: 14, color: grey, fontWeight: FontWeight.bold),),
                    SizedBox(width: MediaQuery.of(context).size.width*.18,),
                    Text("email@gmail.com",style: GoogleFonts.alice(fontSize: 14, color: grey, fontWeight: FontWeight.bold),)
                  ],
                ),

              ],
            ),
          ),
          // ListTile(
          //   onTap:(){
          //     Get.to(const FavouriteScreen());
          //   },
          //   leading:const Icon(Icons.favorite_border,color: grey,),
          //       title:Text("Favourite",style:GoogleFonts.alice(fontSize: 16,fontWeight: FontWeight.w500,color: textBlack),),
          //   trailing:const Icon(Icons.arrow_forward_ios,color: grey,size: 20,) ,
          // ),
          ListTile(
            onTap:(){
              Get.to(const AddressPage());
            },
            leading:const Icon(Icons.home,color: grey,),
            title:Text("Address",style:GoogleFonts.alice(fontSize: 16,fontWeight: FontWeight.w500,color: textBlack),),
            trailing:const Icon(Icons.arrow_forward_ios,color: grey,size: 20,) ,
          ),
          ListTile(
            onTap:(){
              Get.to(const InquiryPage());
            },
            leading:const Icon(Icons.delivery_dining,color: grey,),
            title:Text("Inquiry",style:GoogleFonts.alice(fontSize: 16,fontWeight: FontWeight.w500,color: textBlack),),
            trailing:const Icon(Icons.arrow_forward_ios,color: grey,size: 20,) ,
          ),
          // ListTile(
          //   onTap:(){
          //     Get.to(const SettingPage());
          //   },
          //   leading:const Icon(Icons.settings,color: grey,),
          //   title:Text("Setting",style:GoogleFonts.alice(fontSize: 16,fontWeight: FontWeight.w500,color: textBlack),),
          //   trailing:const Icon(Icons.arrow_forward_ios,color: grey,size: 20,) ,
          // ),
        ],
      ),
    );
  }
}
