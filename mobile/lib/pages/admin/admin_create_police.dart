import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../datamodel.dart';

class CreatePolicePage extends StatefulWidget {
  const CreatePolicePage({Key? key}) : super(key: key);

  @override
  State<CreatePolicePage> createState() => _CreatePolicePageState();
}

class _CreatePolicePageState extends State<CreatePolicePage> {
  DataModel? _dataModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController badgeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController repeatedPasswordController = TextEditingController();
  String btnText = "CREATE";

  Future<DataModel?> submitData(String name, String badgeNumber, String email,
      String phoneNumber, String password) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json'
    };

    var url = Uri.parse('https://adega.onrender.com/signup');
    var body = {
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'name': name,
      'role': "police",
      'badgeNumber': badgeNumber
    };

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    // print(req.body);
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
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(5),
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Image.asset(
                  'assets/logo.png',
                  height: height * 0.3, //height to 9% of screen height,
                  width: width * 0.3,
                ),
              ),
              SizedBox(
                height: height * 0.0, //height to 9% of screen height,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
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
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                child: TextField(
                  style: TextStyle(fontSize: 15.0),
                  controller: badgeController,
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
                    labelText: 'badge number',
                    labelStyle: TextStyle(
                      color: Color(0xFFAEAEAE),
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                child: TextField(
                  style: TextStyle(fontSize: 15.0),
                  controller: emailController,
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
                    labelText: 'email',
                    labelStyle: TextStyle(
                      color: Color(0xFFAEAEAE),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                child: TextField(
                  style: TextStyle(fontSize: 15.0),
                  controller: phoneNumberController,
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
                    labelText: 'phone number',
                    labelStyle: TextStyle(
                      color: Color(0xFFAEAEAE),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 0),
                child: TextField(
                  style: TextStyle(fontSize: 15.0),
                  obscureText: true,
                  controller: passwordController,
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
                    labelText: 'password',
                    labelStyle: TextStyle(
                      color: Color(0xFFAEAEAE),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),


              SizedBox(
                height: height * 0.02,
              ),
              Container(
                  height: height * 0.09,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: Text(btnText),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                      backgroundColor: Color(0xFF2CACE7),
                    ),
                    onPressed: () async {
                      setState(() {
                        btnText = "CREATING...";
                      });
                      String name = nameController.text;
                      String badgeNumber = badgeController.text;
                      String email = emailController.text;
                      String phoneNumber = phoneNumberController.text;

                      String password = passwordController.text;

                      DataModel? data = await submitData(
                          name, badgeNumber, email, phoneNumber, password);
                      setState(() {
                        _dataModel = data;
                      });
                      Navigator.of(context).pop();
                    },
                  )),
            ],
          )),
    );
  }
}
