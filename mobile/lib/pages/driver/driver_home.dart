import 'dart:html';

import 'package:flutter/material.dart';

class DriverHomePage extends StatefulWidget {
  @override
  _DriverHomePageState createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          title: Text(
            'home',
            style: TextStyle(color: Color(0xFFAFAFAF)),
          ),
          centerTitle: true,
        ),
        body: Container(
          alignment: Alignment.center,
          child: Text('home'),
        ),
      );
}
