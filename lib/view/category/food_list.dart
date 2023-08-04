
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xuseme/constant/color.dart';
import '../../constant/app_constants.dart';
import 'category_list.dart';

class FoodList extends StatefulWidget {
  const FoodList({Key? key}) : super(key: key);

  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: btnColor,
        title:  Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 0,0),
          child: TextFormField(
            cursorColor: Colors.black,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(width: 1, color:textWhite),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(width: 1, color:textWhite),
                    borderRadius: BorderRadius.circular(10)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
                labelText: ('Search here'),
                labelStyle: GoogleFonts.alice(color: textWhite),
                contentPadding: const EdgeInsets.only(top: 10, left: 20),
                suffixIcon:SizedBox(
                  width:AppConstants.width(context)*0.3,
                  child: Row(
                    children: [
                      IconButton(onPressed:(){}, icon: const Icon(Icons.search,color: textWhite,)),
                      const Text('|'),
                      IconButton(onPressed:(){
                      }, icon: const Icon(Icons.mic,color: textWhite,))
                    ],
                  ),
                )
            ),
          ),
        ),
      ),
          body: const CategoryList(),

    );
  }
}
