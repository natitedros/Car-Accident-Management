
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../datamodel.dart';
import '../token_checker.dart';

class UserDetailsPage extends StatefulWidget {
  final returenData data;
  const UserDetailsPage({Key? key, required this.data}) : super(key: key);

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {

  String deleteBtn = "Delete Account";
  late String activityStatus;
  late String activationButton;

  @override
  void initState() {
    super.initState();
    activityStatus = (widget.data.isActive!) ? "Active" : "Inactive";
    activationButton = (widget.data.isActive!) ? "Deactivate" : "Activate";
  }

  Future<bool> deleteUser(String id) async {
    String? token = await TokenService().readToken();
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json',
      'Authorization' : 'Bearer $token'
    };
    String ep = "${dotenv.env['STARTING_URI']}/admin/delete/$id";
    var url = Uri.parse(ep);

    var req = http.Request('DELETE', url);
    req.headers.addAll(headersList);
    // log(req.body);
    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    Map temp = jsonDecode(
        resBody); // accepts the data from the server and maps it onto temp
    if (res.statusCode == 200 ||
        res.statusCode == 201 ||
        res.statusCode == 300) {
      return true;
    }
    return false;
  }

  Future<bool> activationUser(String id) async {
    String? token = await TokenService().readToken();
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json',
      'Authorization' : 'Bearer $token'
    };
    String ep = "${dotenv.env['STARTING_URI']}/admin/activation/$id";
    var url = Uri.parse(ep);

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);
    // log(req.body);
    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    Map temp = jsonDecode(
        resBody); // accepts the data from the server and maps it onto temp
    if (res.statusCode == 200 ||
        res.statusCode == 201 ||
        res.statusCode == 300) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFF3AD425)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          elevation: 3,
          title: Text(
            'User Details',
            style: TextStyle(color: Color(0xFF3AD425), fontSize: 15.0),
          ),
          centerTitle: true,
        ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Name:",
                  style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 15.0)),
              Text("${widget.data.name}",
                  style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 25.0)),
              Text("Email:",
                  style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 10.0)),
              Text("${widget.data.email}",
                  style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 20.0)),
              Text("Role:",
                  style: TextStyle(color: Color(0xFFBEBEBE), fontSize: 10.0)),
              Text("${widget.data.role}",
                  style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 20.0)),
              Text("Phone Number:",
                  style: TextStyle(color: Color(0xFFBEBEBE), fontSize: 10.0)),
              Text("${widget.data.phoneNumber}",
                  style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 20.0)),
              Text("Accident Participation:",
                  style: TextStyle(color: Color(0xFFBEBEBE), fontSize: 15.0)),
              Text("${widget.data.caseNumber}",
                  style: TextStyle(color: Color(0xFFBEBEBE), fontSize: 15.0)),
              Text("Activity Status:",
                  style: TextStyle(color: Color(0xFFBEBEBE), fontSize: 15.0)),
              Text(activityStatus,
                  style: TextStyle(color: Color(0xFFBEBEBE), fontSize: 15.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        if (deleteBtn == "User Deleted"){
                          Navigator.of(context).pop();
                          return;
                        }
                        // Function to write to delete the respective user with the email entered
                        setState(() {
                          deleteBtn = "Deleting...";
                        });
                        bool isDeleted = await deleteUser("${widget.data.id}");
                        if (isDeleted){
                          setState(() {
                            deleteBtn = "User Deleted";
                          });
                        }
                        else{
                          setState(() {
                            deleteBtn = "Try Again";
                          });
                        }
                      },
                      child: Text(
                        deleteBtn,
                      )),
                  ElevatedButton(
                      onPressed: () async {
                        // Function to write to delete the respective user with the email entered
                        String temp = activationButton;
                        setState(() {
                           activationButton = "Loading...";
                        });
                        bool isToggled = await activationUser("${widget.data.id}");
                        if (isToggled){
                          if(activityStatus == "Active"){
                            setState(() {
                              activityStatus = "Inactive";
                              activationButton = "Activate";
                            });
                          } else {
                            setState(() {
                              activityStatus = "Active";
                              activationButton = "Deactivate";
                            });
                          }
                        } else{
                          setState(() {
                            activationButton = temp;
                          });
                        }
                      },
                      child: Text(
                        activationButton,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
