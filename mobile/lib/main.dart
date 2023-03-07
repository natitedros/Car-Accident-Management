//import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:car_accident_management/pages/login.dart';
import 'package:car_accident_management/pages/signup.dart';
import 'package:car_accident_management/pages/driver/driver.dart';
import 'package:car_accident_management/pages/admin/admin.dart';
import 'package:car_accident_management/pages/police/police.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Login(),
      '/signup': (context) => Signup(),
    },
    theme: ThemeData(
        fontFamily: 'Feather',
        textTheme: const TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: Color(0xFFAFAFAF),
        )),
  ));
}
