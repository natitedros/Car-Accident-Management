import 'dart:convert';
import 'dart:developer';

import 'package:car_accident_management/pages/token_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../datamodel.dart';

class ChangePassword extends StatelessWidget {
  final String id;
  const ChangePassword({Key? key, required this.id}) : super(key: key);

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
            'Change Password',
            style: TextStyle(fontSize: 15.0),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFFFFC107),
        ),
        body: ChangePasswordStateful(id: id),
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

class ChangePasswordStateful extends StatefulWidget {
  final String? id;
  const ChangePasswordStateful({Key? key, required this.id}) : super(key: key);

  @override
  State<ChangePasswordStateful> createState() => _ChangePasswordStatefulState();
}

class _ChangePasswordStatefulState extends State<ChangePasswordStateful> {
  DataModel? _dataModel;
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController repeatedPasswordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  String changeMessage = "";
  String btnText = "CHANGE PASSWORD";

  Future<String?> changePassword(
    String newPassword,
    String oldPassword,
      String? id
  ) async {
    String? token = await TokenService().readToken();
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json',
      'Authorization' : 'Bearer $token'
    };

    var url = Uri.parse('${dotenv.env['STARTING_URI']}/common/changepassword/$id');
    var body = {
      'newPassword': newPassword,
      'oldPassword': oldPassword,
    };

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    Map temp = jsonDecode(resBody);
    print(temp['message']);
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
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextField(
                  style: TextStyle(fontSize: 15.0),
                  controller: newPasswordController,
                  obscureText: true,
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
                    labelText: 'new password',
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
                  controller: repeatedPasswordController,
                  obscureText: true,
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
                    labelText: 'repeat password',
                    labelStyle: TextStyle(
                      color: Color(0xFFAEAEAE),
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextField(
                  style: TextStyle(fontSize: 15.0),
                  controller: oldPasswordController,
                  obscureText: true,
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
                    labelText: 'old password',
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
                      String newPassword = newPasswordController.text;
                      String repeatedPassword = repeatedPasswordController.text;
                      String oldPassword = oldPasswordController.text;
                      if (newPassword != repeatedPassword){
                        setState(() {
                          changeMessage = "You didn't repeat the password correctly";
                        });
                      } else if(newPassword.length < 6){
                          changeMessage = "The minimum length of password is 6 characters";
                      }else{

                        setState(() {
                          btnText = "Changing...";
                        });
                        String? message = await changePassword(
                            newPassword, oldPassword, widget.id!);
                        setState(() {
                          changeMessage = "$message";
                          btnText = "CHANGE PASSWORD";
                        });
                      }
                    },
                    child: Text(btnText),
                  )),
            ],
          )),
    );
  }
}
