//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:car_accident_management/pages/driver/driver_home.dart';
import 'package:car_accident_management/pages/driver/driver_profile.dart';
import 'package:car_accident_management/pages/driver/driver_cars.dart';
import 'package:car_accident_management/pages/driver/driver_cases.dart';
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
  late final screens = [
    DriverHomePage(),
    DriverCarsPage(),
    DriverCasesPage(data: widget.data),
    DriverProfilePage(data: widget.data),
  ];

  //---------------------------------------------------------------

  // Future<returenCases> fetchCases() async {
  //   final response = await http.get(Uri.parse(
  //       'https://adega.onrender.com/mycases/63d0050fdd72e0a01b0958a2'));
  //   print("I am in response");
  //   print(response.body);
  //   if (response.statusCode == 200 ||
  //       response.statusCode == 201 ||
  //       response.statusCode == 300) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.
  //     print(jsonDecode(response.body));
  //     return returenCases.fromJson(jsonDecode(response.body));
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load album');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // fetchCases();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
                  setState(() => this.index = index),
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
