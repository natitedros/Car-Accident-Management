import 'package:flutter/material.dart';

class DriverCarsPage extends StatefulWidget {
  @override
  _DriverCarsPageState createState() => _DriverCarsPageState();
}

class _DriverCarsPageState extends State<DriverCarsPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          elevation: 0,
          title: Text('Cars'),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Text('Cars'),
        ),
      );
}
