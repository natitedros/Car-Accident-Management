import 'package:car_accident_management/pages/car_info_layout.dart';
import 'package:flutter/material.dart';

import 'add_cars.dart';

class DriverCarsPage extends StatefulWidget {
  @override
  _DriverCarsPageState createState() => _DriverCarsPageState();
}

class _DriverCarsPageState extends State<DriverCarsPage> {
  final List _cars = ['car1', 'car2', 'car3', 'car4', 'car5', 'car6'];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        title: Text(
          'Cars',
          style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 15.0),
        ),
        centerTitle: true,
      ),
      body: Container(
          alignment: Alignment.center,
          child: ListView.builder(
              itemCount: _cars.length,
              itemBuilder: (context, index) {
                return CarInfoLayout(
                  child: _cars[index],
                );
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCar()),
            // (Route<dynamic> route) => false,
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFFCB3D2D),
      ),
    );
  }
}
