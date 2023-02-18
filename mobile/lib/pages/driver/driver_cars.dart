import 'package:car_accident_management/pages/car_info_layout.dart';
import 'package:flutter/material.dart';
import '../../datamodel.dart';

import 'add_cars.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DriverCarsPage extends StatefulWidget {
  @override
  _DriverCarsPageState createState() => _DriverCarsPageState();
}

class _DriverCarsPageState extends State<DriverCarsPage> {
//data Type - List<returenCars>
  Future<void> fetchCars() async {
    final url = Uri.parse(
        'https://adega.onrender.com/driver/mycars/63d0050fdd72e0a01b0958a2');
    http.Response response = await http.get(url);
    Iterable resBody = jsonDecode(response.body);
    // accepts the data from the server and maps it onto temp

    try {
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 300) {
        List<returenCars> Cars = [];
        for (var singleCase in resBody) {
          Cars.add(returenCars(
              id: singleCase['_id'],
              name: singleCase['name'],
              plateNumber: singleCase['plateNumber'],
              ownerId: singleCase['ownerId'],
              region: singleCase['region']));
        }
        //We use teh array Cars to fill out the listcards
        print(Cars[0].name);
        return;
      }
    } catch (err) {
      print(err);
    }
  }

  final List _cars = ['car1', 'car2', 'car3', 'car4', 'car5', 'car6'];
  @override
  void initState() {
    super.initState();
    fetchCars();
  }

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
