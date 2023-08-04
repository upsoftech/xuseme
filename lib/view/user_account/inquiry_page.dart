import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xuseme/constant/color.dart';
import '../../model/inquiry_model.dart';
import '../drawer/drawer_page.dart';
class InquiryPage extends StatefulWidget {
  const InquiryPage({Key? key}) : super(key: key);

  @override
  State<InquiryPage> createState() => _InquiryPageState();
}

class _InquiryPageState extends State<InquiryPage>with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: textBlack),
        elevation: 0,
        title: Text("Inquiry",style:GoogleFonts.alice(color: textBlack,fontSize: 16) ,),

      ),
      body:ListView.builder(
        itemCount:inquiryData.length,
          itemBuilder: (context,index){
        return Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.only(top: 5,bottom: 5),
          width: double.infinity,
          decoration: BoxDecoration(
            color: primary.withOpacity(.05),
            borderRadius: BorderRadius.circular(10),
          ),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: primary.withOpacity(.1),
                    //color: boxColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    inquiryData[index].image,
                    height: 100,
                    width: 90,
                  )),
             const SizedBox(width: 10,),
             SizedBox(
               width: MediaQuery.of(context).size.width*.55,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text(inquiryData[index].process,style:GoogleFonts.alice(fontSize: 16,fontWeight: FontWeight.bold),),
                   const SizedBox(width: 5,),
                   Text(inquiryData[index].services),
                   const SizedBox(width: 5,),
                   Text(inquiryData[index].address),
                   const SizedBox(width: 5,),
                   Text(inquiryData[index].date)
                 ],
               ),
             ),
              Container(
                padding: const EdgeInsets.only(right: 10 ),
                  child: const Icon(Icons.call,size: 25,color: primary,))
            ],
          ),
        );
      }),
    );
  }
}
