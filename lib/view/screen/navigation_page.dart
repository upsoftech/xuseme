import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xuseme/constant/color.dart';
import 'package:xuseme/view/home/home_page.dart';
import '../../model/inquiry_model.dart';
import '../category/category_details.dart';
import '../user_account/inquiry_page.dart';
import '../user_account/setting_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({
    Key? key,
    this.page,
  }) : super(key: key);

  final int? page;

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;

  static final List _widgetOptions = <dynamic>[
    const HomePage(),
    const InquiryPage(),
    //   const SettingPage(),
    const CategoryDetailsList()
  ];

  void _onItemTapped(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.page != null) {
      _selectedIndex = widget.page!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex > 0) {
          _selectedIndex = 0;
          setState(() {});
          return false;
        } else {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Do you want to close app ?'),
                actionsAlignment: MainAxisAlignment.end,
                actions: [
                  TextButton(
                    onPressed: () {
                      exit(0);
                    },
                    child: const Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text('No'),
                  ),
                ],
              );
            },
          );
          return shouldPop!;
        }
      },
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: btnColor,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Inquiry',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.settings),
              //   label: 'Setting',
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.workspace_premium_outlined),
                label: 'Premium',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            selectedItemColor: textBlack,
            unselectedItemColor: textWhite,
            iconSize: 25,
            unselectedLabelStyle: GoogleFonts.alice(fontSize: 11),
            selectedLabelStyle: GoogleFonts.alice(fontSize: 11),
            onTap: _onItemTapped,
            elevation: 5),
      ),
    );
  }
}
