// import 'dart:io';

import 'dart:convert';
import 'dart:developer';

import 'package:car_accident_management/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../datamodel.dart';

void main() => runApp(const Signup());

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: _title,
      home: Scaffold(
        body: const SignupStateful(),
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

class SignupStateful extends StatefulWidget {
  const SignupStateful({Key? key}) : super(key: key);

  @override
  State<SignupStateful> createState() => _SignupStatefulState();
}

class _SignupStatefulState extends State<SignupStateful> {
  DataModel? _dataModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController repeatedPasswordController = TextEditingController();


  Future<DataModel?> submitData(String name, String role, String email,
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
      'role': role
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
      print(res.statusCode);
      print(resBody);

      print(res.reasonPhrase);
    }

    return null;
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
                  controller: roleController,
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
                    labelText: 'role',
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
                    child: const Text('SIGN UP'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                      backgroundColor: Color(0xFF2CACE7),
                    ),
                    onPressed: () async {
                      String name = nameController.text;
                      String role = roleController.text;
                      String email = emailController.text;
                      String phoneNumber = phoneNumberController.text;

                      String password = passwordController.text;
                      // print(name);
                      // print(role);
                      // print(email);
                      // print(password);

                      DataModel? data = //await getData();
                          await submitData(
                              name, role, email, phoneNumber, password);

                      setState(() {
                        _dataModel = data;
                      });
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 15, 40, 0),
                child: Center(
                  child: Text(
                    "OR",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFFAFAFAF),
                    ),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: Color(0xFFAFAFAF),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  TextButton(
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                        color: Color(0xFF2CACE7),
                      ),
                    ),
                    onPressed: () {
                      //signup screen
                      // Navigator.pushReplacementNamed(context, '/');
                      // Navigator.pushNamed(context, MaterialPageRoute(builder: (context) => Login()));

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              SizedBox(height: height * 0.02),
              const Center(
                child: Text(
                  "By signing in, you agree to our Terms and Privacy Policy",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFAFAFAF),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
