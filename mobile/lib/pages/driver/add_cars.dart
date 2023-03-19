import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../datamodel.dart';

class AddCar extends StatelessWidget {
  final returenData data;
  const AddCar({Key? key, required this.data}) : super(key: key);
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
        body: AddCarStateful(data: data,),
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
  final returenData data;
  const AddCarStateful({Key? key, required this.data}) : super(key: key);

  @override
  State<AddCarStateful> createState() => _AddCarStatefulState();
}

class _AddCarStatefulState extends State<AddCarStateful> {
  DataModel? _dataModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  bool _validateName = false;
  bool _validateModel = false;
  bool _validateColor = false;
  bool _validateRegion = false;
  bool _validatePlate = false;
  String addBtn = "ADD CAR";
  String addStatus = "";


  Future<DataModel?> submitData(
      String name,
      String model,
      String color,
      String plate,
      String region
  ) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json'
    };

    var url = Uri.parse('https://adega.onrender.com/driver/addcar');
    var body = {
      'name': name,
      'model': model,
      'color': color,
      'plateNumber': plate,
      'region': region,
      'ownerId': widget.data.id
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
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      //height: height * 0.1, //height to 10% of screen height, 100/10 = 0.1
      //width: width * 0.7, //width t 70% of screen width
      child: Padding(
          padding: const EdgeInsets.all(5),
          child: ListView(
            children: <Widget>[

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
                    errorText: _validateName ? 'Value Can\'t Be Empty' : null,
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
                    errorText: _validateModel ? 'Value Can\'t Be Empty' : null,
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
                    errorText: _validateColor ? 'Value Can\'t Be Empty' : null,
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
                  controller: regionController,
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
                    labelText: 'region',
                    errorText: _validateRegion ? 'Value Can\'t Be Empty' : null,
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
                  controller: plateNumberController,
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
                    errorText: _validatePlate ? 'Value Can\'t Be Empty' : null,
                    labelStyle: TextStyle(
                      color: Color(0xFFAEAEAE),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Container(
                  height: height * 0.09,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: Text('ADD CAR'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                      backgroundColor: Color(0xFFCB3D2D),
                    ),
                    onPressed: () async {
                      setState(() {
                        addBtn = "Adding...";
                        addStatus = "";
                      });
                      String name = nameController.text;
                      String model = modelController.text;
                      String color = colorController.text;
                      String plateNumber = plateNumberController.text;
                      String region = regionController.text;
                      bool allAvailable = true;
                      setState(() {
                        if(nameController.text.isEmpty){
                          _validateName = true;
                          allAvailable = false;
                        }
                        else{
                          _validateName = false;
                        }
                        if(modelController.text.isEmpty){
                          _validateModel = true;
                          allAvailable = false;
                        }
                        else{
                          _validateModel = false;
                        }
                        if(colorController.text.isEmpty){
                          _validateColor = true;
                          allAvailable = allAvailable && false;
                        }else{
                          _validateColor = false;
                        }
                        if(plateNumberController.text.isEmpty){
                          _validatePlate = true;
                          allAvailable = false;
                        }
                        else{
                          _validatePlate = false;
                        }
                        if(regionController.text.isEmpty){
                          _validateRegion = true;
                          allAvailable = false;
                        }
                        else{
                          _validateRegion = false;
                        }

                      });
                      if(allAvailable){
                        DataModel? data = await submitData(name, model, color, plateNumber, region);
                        setState(() {
                          addBtn = "ADD CAR";
                          addStatus = "Added!";
                        });
                      }

                      // setState(() {
                      //   _dataModel = data;
                      // });
                    },
                  )),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(child: Text(
                    "$addStatus",
                    style: TextStyle(
                      fontSize: 19
                    ),
                )),
              )
            ],
          )),
    );
  }
}
