// import 'package:http/http.dart';
import '../../datamodel.dart';
import '../changepassword.dart';
import '../changenumber.dart';

// import 'dart:convert';
// import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:car_accident_management/pages/login.dart';

class AdminProfilePage extends StatefulWidget {
  final returenData data;
  const AdminProfilePage({Key? key, required this.data}) : super(key: key);

  @override
  _AdminProfilePageState createState() {
    return _AdminProfilePageState();
  }
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  @override
  void initState() {
    super.initState();
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
          'Profile',
          style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 15.0),
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(children: <Widget>[
          SizedBox(
            height: height * 0.03,
          ),
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFAFAFAF),
            ),
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 80,
            ),
            alignment: Alignment.center,
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Text("${widget.data.name}",
              style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 30.0)),
          Text("${widget.data.role}",
              style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 20.0)),
          SizedBox(
            height: height * 0.03,
          ),
          Text("${widget.data.email}",
              style: TextStyle(color: Color(0xFFBEBEBE), fontSize: 15.0)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("+ 251933908669",
                style: TextStyle(color: Color(0xFFBEBEBE), fontSize: 15.0)),
          ),
          SizedBox(
            height: height * 0.15,
          ),
          TextButton(
            child: const Text(
              'Change Password',
              style: TextStyle(
                color: Color(0xFFFFC107),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePassword()),
                // (Route<dynamic> route) => false,
              );
            },
          ),
          SizedBox(
            height: height * 0.02,
          ),
          TextButton(
            child: const Text(
              'Change Phone Number',
              style: TextStyle(
                color: Color(0xFFFFC107),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePhone()),
                // (Route<dynamic> route) => false,
              );
            },
          ),
        ]),
      ),
    );
  }
}
