// import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:car_accident_management/pages/login.dart';
import 'package:car_accident_management/pages/signup.dart';
import 'package:car_accident_management/pages/driver/driver.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Login(),
      '/signup': (context) => Signup(),
      '/driver': (context) => DriverPage(),
    },
    theme: ThemeData(
        fontFamily: 'Feather',
        textTheme: TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: Color(0xFFAFAFAF),
        )),
  ));
}
