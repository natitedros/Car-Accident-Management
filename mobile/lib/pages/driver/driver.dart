//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:car_accident_management/pages/driver/driver_home.dart';
import 'package:car_accident_management/pages/driver/driver_profile.dart';
import 'package:car_accident_management/pages/driver/driver_cars.dart';
import 'package:car_accident_management/pages/driver/driver_cases.dart';
import 'package:car_accident_management/pages/login.dart';
import 'package:car_accident_management/datamodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// void main() => runApp(DriverPage());

class DriverPage extends StatefulWidget {
  final returenData data;
  const DriverPage({Key? key, required this.data}) : super(key: key);
  @override
  _DriverPageState createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  int index = 0;
  String title0 = "Home";
  String title1 = "Cars";
  String title2 = "Cases";
  String title3 = "Profile";
  String mainTitle = "Home";
  late final screens = [
    DriverHomePage(data: widget.data),
    DriverCarsPage(data: widget.data),
    DriverCasesPage(data: widget.data),
    DriverProfilePage(data: widget.data),
  ];

  @override
  void initState() {
    super.initState();
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
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                      (Route<dynamic> route) => false,
                );
              },
            )
          ],
        ),
        body: screens[index],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              indicatorColor: Colors.white,
              labelTextStyle: MaterialStateProperty.all(
                TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              )),
          child: NavigationBar(
              height: 60,
              backgroundColor: Colors.white,
              elevation: 5,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              selectedIndex: index,
              onDestinationSelected: (index) =>
                  setState(() {
                    this.index = index;
                    if (index == 0){
                      mainTitle = title0;
                    }
                    else if (index == 1){
                      mainTitle = title1;
                    }
                    else if (index == 2){
                      mainTitle = title2;
                    }
                    else if (index == 3){
                      mainTitle = title3;
                    }
                  } ),
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
                    label: 'Home'),
                NavigationDestination(
                    icon: Icon(
                      Icons.car_repair_outlined,
                      color: Color(0xFFAFAFAF),
                    ),
                    selectedIcon: Icon(
                      Icons.car_repair_outlined,
                      color: Color(0xFFCB3D2D),
                    ),
                    label: 'Cars'),
                NavigationDestination(
                    icon: Icon(
                      Icons.file_copy_outlined,
                      color: Color(0xFFAFAFAF),
                    ),
                    selectedIcon: Icon(
                      Icons.file_copy_outlined,
                      color: Color(0xFF3AD425),
                    ),
                    label: 'Cases'),
                NavigationDestination(
                    icon: Icon(
                      Icons.person_outline_rounded,
                      color: Color(0xFFAFAFAF),
                    ),
                    selectedIcon: Icon(
                      Icons.person_outline_rounded,
                      color: Color(0xFFFFC107),
                    ),
                    label: 'Profile'),
              ]),
        ),
      );
}
