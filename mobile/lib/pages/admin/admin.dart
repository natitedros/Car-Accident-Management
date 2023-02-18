//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:car_accident_management/pages/admin/admin_profile.dart';
import 'package:car_accident_management/pages/admin/admin_home.dart';
import 'package:car_accident_management/pages/admin/admin_cases.dart';
import 'package:car_accident_management/datamodel.dart';

// import 'package:car_accident_management/pages/driver/driver_cases.dart';

// void main() => runApp(AdminPage());

class AdminPage extends StatefulWidget {
  final returenData data;
  const AdminPage({Key? key, required this.data}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int index = 0;
  late final screens = [
    AdminHomePage(),
    AdminCasesPage(data: widget.data),
    AdminProfilePage(data: widget.data),
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
                // NavigationDestination(
                //     icon: Icon(
                //       Icons.car_repair_outlined,
                //       color: Color(0xFFAFAFAF),
                //     ),
                //     selectedIcon: Icon(
                //       Icons.car_repair_outlined,
                //       color: Color(0xFFCB3D2D),
                //     ),
                //     label: 'Cars'),
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
