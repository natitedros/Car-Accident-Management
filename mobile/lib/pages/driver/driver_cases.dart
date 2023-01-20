import 'package:flutter/material.dart';

class DriverCasesPage extends StatefulWidget {
  @override
  _DriverCasesPageState createState() => _DriverCasesPageState();
}

class _DriverCasesPageState extends State<DriverCasesPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          elevation: 0,
          title: Text('Cases'),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Text('Cases'),
        ),
      );
}
