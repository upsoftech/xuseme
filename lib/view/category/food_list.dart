import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:xuseme/constant/color.dart';
import 'package:xuseme/model/category_model.dart';
import '../../constant/app_constants.dart';
import '../../provider/category_provider.dart';
import 'category_list.dart';

class FoodList extends StatefulWidget {
  const FoodList({Key? key}) : super(key: key);

  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  late CategoryProvider categoryProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    categoryProvider.getCategoryData();
  }

  @override
  Widget build(BuildContext context) {
    categoryProvider = Provider.of<CategoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: btnColor,
        title: Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: TextFormField(
            cursorColor: textWhite,
            style: const TextStyle(color: textWhite),
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: textWhite),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: textWhite),
                    borderRadius: BorderRadius.circular(10)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: ('Search here'),
                labelStyle: GoogleFonts.alice(color: textWhite),
                contentPadding: const EdgeInsets.only(top: 10, left: 20),
                suffixIcon: SizedBox(
                  width: AppConstants.width(context) * 0.3,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            color: textWhite,
                          )),
                      const Text('|'),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.mic,
                            color: textWhite,
                          ))
                    ],
                  ),
                )),
          ),
        ),
      ),
      body: Center(
          child: categoryProvider.isLoading
              ? const CircularProgressIndicator(
                  color: btnColor,
                )
              : categoryProvider.categoryList.isEmpty
                  ? Center(
                      child: Text(
                        "No Data Found",
                        style: GoogleFonts.alice(
                            color: btnColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  : const CategoryList()),
    );
  }
}
