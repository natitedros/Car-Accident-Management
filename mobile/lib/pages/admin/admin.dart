import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:car_accident_management/pages/token_checker.dart';
import 'package:flutter/material.dart';
import 'package:car_accident_management/pages/admin/admin_profile.dart';
import 'package:car_accident_management/pages/admin/admin_home.dart';
import 'package:car_accident_management/pages/admin/admin_cases.dart';
import 'package:car_accident_management/datamodel.dart';
import 'package:car_accident_management/pages/login.dart';
import 'package:http/http.dart' as http;

class AdminPage extends StatefulWidget {
  final returenData data;
  const AdminPage({Key? key, required this.data}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int index = 0;
  String title0 = "Home";
  String title1 = "Cases";
  String title2 = "Profile";
  String mainTitle = "Home";
  List<returenCases>? casesList;

  final PageController _pageController = PageController();

  late final screens = [
    AdminHomePage(data: widget.data),
    AdminCasesPage(data: widget.data),
    AdminProfilePage(data: widget.data),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int newIndex) {
    setState(() {
      index = newIndex;
      if (newIndex == 0) {
        mainTitle = title0;
      } else if (newIndex == 1) {
        mainTitle = title1;
      } else if (newIndex == 2) {
        mainTitle = title2;
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
            TokenService().removeTokenUser();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Login()),
                  (Route<dynamic> route) => false,
            );
          },
        )
      ],
    ),
    body: GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          // Swiped from left to right
          if (index > 0) {
            setState(() {
              index--;
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            });
          }
        } else if (details.primaryVelocity! < 0) {
          // Swiped from right to left
          if (index < screens.length - 1) {
            setState(() {
              index++;
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            });
          }
        }
      },
      child: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: screens,
        onPageChanged: _onPageChanged,
      ),
    ),
    bottomNavigationBar: NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: Colors.white,
        labelTextStyle: MaterialStateProperty.all(
          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
      child: NavigationBar(
        height: 60,
        backgroundColor: Colors.white,
        elevation: 5,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        selectedIndex: index,
        onDestinationSelected: (newIndex) {
          setState(() {
            index = newIndex;
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            if (index == 0) {
              mainTitle = title0;
            } else if (index == 1) {
              mainTitle = title1;
            } else if (index == 2) {
              mainTitle = title2;
            }
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
              color: Color(0xFFAFAFAF),
            ),
            selectedIcon: Icon(
              Icons.home_outlined,
              color: Color(0xFF2CACE7),
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.file_copy_outlined,
              color: Color(0xFFAFAFAF),
            ),
            selectedIcon: Icon(
              Icons.file_copy_outlined,
              color: Color(0xFF3AD425),
            ),
            label: 'Cases',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.person_outline_rounded,
              color: Color(0xFFAFAFAF),
            ),
            selectedIcon: Icon(
              Icons.person_outline_rounded,
              color: Color(0xFFFFC107),
            ),
            label: 'Profile',
          ),
        ],
      ),
    ),
  );
}
