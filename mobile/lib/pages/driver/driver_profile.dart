import 'package:flutter/material.dart';

class DriverProfilePage extends StatefulWidget {
  @override
  _DriverProfilePageState createState() => _DriverProfilePageState();
}

class _DriverProfilePageState extends State<DriverProfilePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          elevation: 0,
          title: Text('profile'),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Text('profile'),
        ),
      );
}
