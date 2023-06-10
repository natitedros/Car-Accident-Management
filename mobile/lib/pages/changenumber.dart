import 'dart:convert';
import 'dart:developer';

import 'package:car_accident_management/pages/token_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ChangePhone extends StatelessWidget {
  final String id;
  const ChangePhone({Key? key, required this.id}) : super(key: key);


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
            'Change Phone Number',
            style: TextStyle(fontSize: 15.0),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFFFFC107),
        ),
        body: ChangePhoneStateful(id: id),
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

class ChangePhoneStateful extends StatefulWidget {
  final String id;
  const ChangePhoneStateful({Key? key, required this.id}) : super(key: key);

  @override
  State<ChangePhoneStateful> createState() => _ChangePhoneStatefulState();
}

class _ChangePhoneStatefulState extends State<ChangePhoneStateful> {
  TextEditingController newPhoneController = TextEditingController();
  String changeMessage = "";
  String btnText = "CHANGE NUMBER";

  Future<String?> changeNumber(
      String newNumber,
      String? id
      ) async {
    String? token = await TokenService().readToken();
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json',
      'Authorization' : 'Bearer $token'
    };

    var url = Uri.parse('${dotenv.env['STARTING_URI']}/common/changenumber/$id');
    var body = {
      'newNumber': newNumber
    };

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    Map temp = jsonDecode(resBody);
    return temp['message'];

  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      child: Padding(
          padding: const EdgeInsets.all(5),
          child: ListView(
            children: <Widget>[

              SizedBox(
                height: height * 0.2, //height to 9% of screen height,
              ),
              // SizedBox(height: 20.0),

              Container(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextField(
                  style: TextStyle(fontSize: 15.0),
                  controller: newPhoneController,
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
                    labelText: 'new phone number',
                    labelStyle: TextStyle(
                      color: Color(0xFFAEAEAE),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.06,
              ),
              Center(
                child: Text(
                  changeMessage,
                  style: TextStyle(color: Colors.red, fontSize: 12.0),
                ),
              ),
              SizedBox(
                height: height * 0.06,
              ),
              Container(
                  height: height * 0.09,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                      backgroundColor: Color(0xFFFFC107),
                    ),
                    onPressed: () async {
                      setState(() {
                        btnText = "Changing...";
                      });
                      String? message = await changeNumber(
                          newPhoneController.text, widget.id!);
                      setState(() {
                        changeMessage = "$message";
                        btnText = "CHANGE PASSWORD";
                      });
                    },
                    child: Text(btnText),
                  )),
            ],
          )),
    );
  }
}
