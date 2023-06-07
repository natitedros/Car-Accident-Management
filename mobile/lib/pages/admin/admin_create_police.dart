import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../datamodel.dart';
import '../token_checker.dart';

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
  String errorEmail = "";
  String errorPassword = "";
  String errorName = "";
  String errorPhoneNumber = "";
  String errorBadgeNumber = "";
  String btnText = "CREATE";

  Future<returenData> submitData(String name, String badgeNumber, String email,
      String phoneNumber, String password) async {
    String? token = await TokenService().readToken();
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json',
      'Authorization' : 'Bearer $token'
    };

    var url = Uri.parse('${dotenv.env['STARTING_URI']}/signup');
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
    Map temp = jsonDecode(
        resBody);
    if (res.statusCode == 200 ||
        res.statusCode == 201 ||
        res.statusCode == 300) {
      returenData data = returenData(
        name: temp['user']['name'],
        email: temp['user']['email'],
        phoneNumber: temp['user']['phoneNumber'],
        role: temp['user']['role'],
        id: temp['user']['_id'],
      );
      return data;
    } else {
      returenData data = returenData(errors: Map.from(temp['errors']));
      return data;
    }

  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF3AD425)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 3,
        title: Text(
          'Police Information',
          style: TextStyle(color: Color(0xFF3AD425), fontSize: 15.0),
        ),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(5),
          child: ListView(
            children: <Widget>[
              Center(
                child: Text(
                  'Enter Police information below',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.01, //height to 9% of screen height,
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
              Center(
                  child: Text(
                    "$errorName",
                    style: TextStyle(color: Colors.red, fontSize: 10.0),
                  )),
              SizedBox(
                height: height * 0.02,
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
              Center(
                  child: Text(
                    "$errorBadgeNumber",
                    style: TextStyle(color: Colors.red, fontSize: 10.0),
                  )),
              SizedBox(
                height: height * 0.02,
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
              Center(
                  child: Text(
                    "$errorEmail",
                    style: TextStyle(color: Colors.red, fontSize: 10.0),
                  )),
              SizedBox(
                height: height * 0.02,
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
              Center(
                  child: Text(
                    "$errorPhoneNumber",
                    style: TextStyle(color: Colors.red, fontSize: 10.0),
                  )),
              SizedBox(
                height: height * 0.02,
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
              Center(
                  child: Text(
                    "$errorPassword",
                    style: TextStyle(color: Colors.red, fontSize: 10.0),
                  )),
              SizedBox(
                height: height * 0.02,
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
                        btnText = "Creating...";
                      });
                      String name = nameController.text;
                      String badgeNumber = badgeController.text;
                      String email = emailController.text;
                      String phoneNumber = phoneNumberController.text;

                      String password = passwordController.text;

                      returenData data = await submitData(
                          name, badgeNumber, email, phoneNumber, password);
                      if (data.errors != null){
                        setState(() {
                          errorEmail = data.errors!['email']!;
                          errorPassword = data.errors!['password']!;
                          errorPhoneNumber = data.errors!['phoneNumber']!;
                          errorName = data.errors!['name']!;
                          // errorBadgeNumber = data.errors!['badgeNumber']!;
                          btnText = "CREATE";
                        });
                      }
                      else{
                        setState(() {
                          btnText = "DONE";
                        });
                        Navigator.of(context).pop();
                      }
                    },
                  )),
            ],
          )),
    );
  }
}
