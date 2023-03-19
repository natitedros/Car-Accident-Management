// import 'dart:html';

import 'package:car_accident_management/pages/driver/choose_cars.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class DriverHomePage extends StatefulWidget {
  @override
  _DriverHomePageState createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  Future<Position?> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Cannot get the user's location");
        return null;
      }
    }
    Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return pos;
  }



  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(

      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: width * 0.5,
              height: height * 0.2,
              child: ElevatedButton(
                onPressed: () async {
                  Position? pos = await getLocation();
                  if (pos != null){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            ChooseCarsPage()),
                      // (Route<dynamic> route) => false,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        width: 3.0,
                        color: Color(0xFF2CACE7),
                      )),
                  backgroundColor: Color.fromARGB(255, 245, 252, 255),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  textStyle: TextStyle(),
                ),
                child: Column(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        Icons.location_on_sharp,
                        color: Color(0xFF2CACE7),
                        size: 40.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        "Call Nearby Police",
                        style: TextStyle(
                          fontFamily: 'Feather',
                          color: Color(0xFF2CACE7),
                          fontSize: 15.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.1),
            SizedBox(
              width: width * 0.5,
              height: height * 0.2,
              child: ElevatedButton(
                onPressed: () => {},
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        width: 3.0,
                        color: Colors.amber,
                      )),
                  backgroundColor: Color.fromARGB(255, 255, 254, 248),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  textStyle: TextStyle(),
                ),
                child: Column(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        Icons.camera,
                        color: Colors.amber,
                        size: 40.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        "Upload Photo",
                        style: TextStyle(
                          fontFamily: 'Feather',
                          color: Colors.amber,
                          fontSize: 15.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
