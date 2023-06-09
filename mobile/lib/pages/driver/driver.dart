import 'package:flutter/material.dart';
import 'package:car_accident_management/pages/driver/driver_home.dart';
import 'package:car_accident_management/pages/driver/driver_profile.dart';
import 'package:car_accident_management/pages/driver/driver_cars.dart';
import 'package:car_accident_management/pages/driver/driver_cases.dart';
import 'package:car_accident_management/pages/login.dart';
import 'package:car_accident_management/datamodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../token_checker.dart';

class DriverPage extends StatefulWidget {
  final returenData data;
  const DriverPage({Key? key, required this.data}) : super(key: key);

  @override
  _DriverPageState createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  int currentIndex = 0;
  String title0 = "Home";
  String title1 = "Cars";
  String title2 = "Cases";
  String title3 = "Profile";
  String mainTitle = "Home";
  late final PageController pageController;
  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      DriverHomePage(data: widget.data),
      DriverCarsPage(data: widget.data),
      DriverCasesPage(data: widget.data),
      DriverProfilePage(data: widget.data),
    ];
    pageController = PageController(initialPage: currentIndex);
  }

  void onPageChanged(int pageIndex) {
    setState(() {
      currentIndex = pageIndex;
      if (currentIndex == 0) {
        mainTitle = title0;
      } else if (currentIndex == 1) {
        mainTitle = title1;
      } else if (currentIndex == 2) {
        mainTitle = title2;
      } else if (currentIndex == 3) {
        mainTitle = title3;
      }
    });
  }

  void onTabTapped(int tabIndex) {
    setState(() {
      currentIndex = tabIndex;
      if (currentIndex == 0) {
        mainTitle = title0;
      } else if (currentIndex == 1) {
        mainTitle = title1;
      } else if (currentIndex == 2) {
        mainTitle = title2;
      } else if (currentIndex == 3) {
        mainTitle = title3;
      }
      pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        title: Text(
          mainTitle,
          style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 15.0),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Color(0xFFFFC107),
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Login()),
                    (Route<dynamic> route) => false,
              );
            },
          )
        ],
      ),
      body: PageView(
        controller: pageController,
        children: screens,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 5,
        currentIndex: currentIndex,
        onTap: onTabTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,// Set the highlight color
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: Color(0xFFAFAFAF),
            ),
            label: 'Home',
            activeIcon: Icon( // Define the active icon
              Icons.home_outlined,
                color: Color(0xFF2CACE7) // Set the active color
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.car_repair_outlined,
              color: Color(0xFFAFAFAF),
            ),
            label: 'Cars',
            activeIcon: Icon( // Define the active icon
                Icons.car_repair_outlined,
                color: Color(0xFFCB3D2D) // Set the active color
            ),

          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.file_copy_outlined,
              color: Color(0xFFAFAFAF),
            ),
            label: 'Cases',
            activeIcon: Icon( // Define the active icon
                Icons.file_copy_outlined,
                color: Color(0xFF3AD425) // Set the active color
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline_rounded,
              color: Color(0xFFAFAFAF),
            ),

            label: 'Profile',
            activeIcon: Icon( // Define the active icon
                Icons.person_outline_rounded,
                color: Colors.amber // Set the active color
            ),
          ),
        ],
      ),
    );
  }
}
