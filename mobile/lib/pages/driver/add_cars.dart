import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../datamodel.dart';

void main() => runApp(const AddCar());

class AddCar extends StatelessWidget {
  const AddCar({Key? key}) : super(key: key);

  // static const String _title = 'Sample App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: _title,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'Add car',
            style: TextStyle(fontSize: 15.0),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFFCB3D2D),
        ),
        body: const AddCarStateful(),
      ),
      theme: ThemeData(
          fontFamily: 'Feather',
          textTheme: TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
          ).apply(
            bodyColor: Color(0xFFAFAFAF),
          )),
    );
  }
}

class AddCarStateful extends StatefulWidget {
  const AddCarStateful({Key? key}) : super(key: key);

  @override
  State<AddCarStateful> createState() => _AddCarStatefulState();
}

class _AddCarStatefulState extends State<AddCarStateful> {
  DataModel? _dataModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController plateController = TextEditingController();

  Future<DataModel?> submitData(
    String name,
    String model,
    String color,
    String plate,
  ) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json'
    };

    var url = Uri.parse('https://adega.onrender.com/addcar');
    var body = {
      'name': name,
      'model': model,
      'color': color,
      'plate': plate,
    };

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    print(req.body);
    if (res.statusCode == 201 || res.statusCode == 300) {
      print(resBody);
    } else {
      print(res.reasonPhrase);
    }

    return null;

    // var headers = {
    //   'Content-Type': 'application/json',
    //   'Cookie':
    //       'jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzY2ZkMWM1M2M4M2NjNGU3ZDBjNzU5ZiIsImlhdCI6MTY3NDU3MTAyMywiZXhwIjoxNjc0ODMwMjIzfQ.Un4CcfQiZK-YFZ5YSX-Idq4FihEFKXE0iimyWQGhBE0'
    // };
    // var request =
    //     http.Request('POST', Uri.parse('https://adega.onrender.com/login'));
    // request.body =
    //     json.encode({"email": "nati@google.com", "password": "1234567"});
    // request.headers.addAll(headers);
    // var response = await request.send();
    // log(request.toString());
    // print(response);
    // // http.StreamedResponse response = await request.send();

    // if (response.statusCode == 200) {
    //   print(await response.stream.bytesToString());
    // } else {
    //   print(response.reasonPhrase);
    // }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // print(height);
    // print(width);

    return Container(
      //height: height * 0.1, //height to 10% of screen height, 100/10 = 0.1
      //width: width * 0.7, //width t 70% of screen width
      child: Padding(
          padding: const EdgeInsets.all(5),
          child: ListView(
            children: <Widget>[
              // Container(
              //   alignment: Alignment.center,
              //   padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              //   child: Image.asset(
              //     'assets/logo.png',
              //     height: height * 0.3, //height to 9% of screen height,
              //     width: width * 0.3,
              //   ),
              // ),
              SizedBox(
                height: height * 0.1, //height to 9% of screen height,
              ),
              // SizedBox(height: 20.0),

              Container(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextField(
                  style: TextStyle(fontSize: 15.0),
                  controller: nameController,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Color(0xFFF5F5F5),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFE4E4E4),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF2CACE7),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'name',
                    labelStyle: TextStyle(
                      color: Color(0xFFAEAEAE),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextField(
                  style: TextStyle(fontSize: 15.0),
                  controller: modelController,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Color(0xFFF5F5F5),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFE4E4E4),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF2CACE7),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'model',
                    labelStyle: TextStyle(
                      color: Color(0xFFAEAEAE),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextField(
                  style: TextStyle(fontSize: 15.0),
                  controller: colorController,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Color(0xFFF5F5F5),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFE4E4E4),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF2CACE7),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'color',
                    labelStyle: TextStyle(
                      color: Color(0xFFAEAEAE),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextField(
                  style: TextStyle(fontSize: 15.0),
                  controller: plateController,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Color(0xFFF5F5F5),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFE4E4E4),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF2CACE7),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Licence plate Number',
                    labelStyle: TextStyle(
                      color: Color(0xFFAEAEAE),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: height * 0.15,
              ),
              Container(
                  height: height * 0.09,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('ADD CAR'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                      backgroundColor: Color(0xFFCB3D2D),
                    ),
                    onPressed: () async {
                      String name = nameController.text;
                      String model = modelController.text;
                      String color = colorController.text;
                      String plate = plateController.text;
                      // print(newPassword);
                      // print(repeatedPassword);
                      // print(oldPaswword);

                      DataModel? data = //await getData();
                          await submitData(name, model, color, plate);

                      setState(() {
                        _dataModel = data;
                      });
                    },
                  )),
            ],
          )),
    );
  }
}