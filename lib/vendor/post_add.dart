import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/color.dart';
import 'by_company.dart';
import 'by_self.dart';
class PostAdd extends StatefulWidget {
  const PostAdd({Key? key}) : super(key: key);

  @override
  State<PostAdd> createState() => _PostAddState();
}

class _PostAddState extends State<PostAdd>
    with SingleTickerProviderStateMixin {

  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
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
      bottomNavigationBar: GestureDetector(
        onTap:(){
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          alignment: Alignment.center,
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
              color: textBlack,
              borderRadius: BorderRadius.circular(15)
          ),
          child: Text("Pay",style: GoogleFonts.alice(color: textWhite,fontSize: 16,fontWeight: FontWeight.bold),),
        ),
      ),
      appBar: AppBar(
        backgroundColor: btnColor,
        elevation: 0,
        centerTitle: true,
        title: Text("Post Add",style: GoogleFonts.alice(color: textWhite,fontWeight: FontWeight.bold,fontSize: 16),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color:btnColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: TabBar(
                        labelStyle:GoogleFonts.alice(color: textWhite,fontWeight: FontWeight.bold,fontSize: 16),
                        unselectedLabelColor: Colors.white,
                        labelColor: textBlack,
                        indicatorColor: textWhite,
                        indicatorWeight: 2,
                        indicator: BoxDecoration(
                          color: textWhite,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        controller: tabController,
                        tabs: const [
                          Tab(
                            text: 'By Self',
                          ),
                          Tab(
                            text: 'By Company',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    BySelf(),
                    ByCompany(),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
