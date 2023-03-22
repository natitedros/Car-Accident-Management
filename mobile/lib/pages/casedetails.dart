import 'package:http/http.dart';
import '../../datamodel.dart';

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:car_accident_management/pages/login.dart';

// void main() => runApp(CaseDetailPage());

class CaseDetailPage extends StatelessWidget {
  final returenCases? child;
  const CaseDetailPage({Key? key, required this.child}) : super(key: key);
  // CaseDetailPage({this.child});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    DateTime caseTime = DateTime.parse("${child?.createdAt}");


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF3AD425)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 3,
        title: Text(
          'Details',
          style: TextStyle(color: Color(0xFF3AD425), fontSize: 15.0),
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(children: <Widget>[
          SizedBox(
            height: height * 0.03,
          ),
          Text("Accident time:",
              style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 25.0)),
          Text("${caseTime.day}/${caseTime.month}/${caseTime.year}  at   ${caseTime.hour}:${caseTime.minute}",
              style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 20.0)),
          SizedBox(
            height: height * 0.02,
          ),
          Text("Status: ${child?.status}",
              style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 20.0)),
          Text("Severity: ${child?.severity}",
              style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 20.0)),
          Text("Car: ${child?.carName}-${child?.carModel}-${child?.carColor}",
              style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 20.0)),
          Text("Plate Number: ${child?.carPlateNumber}",
              style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 20.0)),
          SizedBox(
            height: height * 0.02,
          ),
          SizedBox(
            height: height * 0.05,
          ),
          Text("Verdict: ${child?.verdict}",
              style: TextStyle(color: Color(0xFFBEBEBE), fontSize: 20.0)),
        ]),
      ),
    );
  }
}
