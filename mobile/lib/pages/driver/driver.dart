//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:car_accident_management/pages/driver/driver_home.dart';
import 'package:car_accident_management/pages/driver/driver_profile.dart';
import 'package:car_accident_management/pages/driver/driver_cars.dart';
import 'package:car_accident_management/pages/driver/driver_cases.dart';

void main() => runApp(DriverPage());

class DriverPage extends StatefulWidget {
  @override
  _DriverPageState createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  int index = 0;
  final screens = [
    DriverHomePage(),
    DriverProfilePage(),
    DriverCarsPage(),
    DriverCasesPage(),
  ];

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
              elevation: 2,
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
                      color: Color.fromARGB(255, 203, 61, 45),
                    ),
                    label: 'Cars'),
                NavigationDestination(
                    icon: Icon(
                      Icons.file_copy_outlined,
                      color: Color(0xFFAFAFAF),
                    ),
                    selectedIcon: Icon(
                      Icons.file_copy_outlined,
                      color: Color(0xFFFFC107),
                    ),
                    label: 'Cases'),
                NavigationDestination(
                    icon: Icon(
                      Icons.person_outline_rounded,
                      color: Color(0xFFAFAFAF),
                    ),
                    selectedIcon: Icon(
                      Icons.person_outline_rounded,
                      color: Color(0xFF643A71),
                    ),
                    label: 'Profile'),
              ]),
        ),
      );
}
