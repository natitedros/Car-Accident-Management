import 'package:http/http.dart';
import '../../datamodel.dart';

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:car_accident_management/pages/login.dart';

void main() => runApp(CaseDetailPage());

class CaseDetailPage extends StatefulWidget {
  @override
  _CaseDetailPageState createState() {
    return _CaseDetailPageState();
  }
}

class _CaseDetailPageState extends State<CaseDetailPage> {
  // void fetchData() async {
  //   Response response =
  //       await get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));
  //   log(response.body);
  //   log('hi');
  // }

  @override
  void initState() {
    super.initState();
    // fetchData();
  }

  // String? role = "";

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
          Text("Date: 19/20/2020",
              style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 30.0)),
          Text("Time: 16:25",
              style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 20.0)),
          Text("Handler: Lealem Kinfe",
              style: TextStyle(color: Color(0xFFBEBEBE), fontSize: 15.0)),
          SizedBox(
            height: height * 0.15,
          ),
          Text("Verdict: ",
              style: TextStyle(color: Color(0xFFBEBEBE), fontSize: 15.0)),
        ]),
      ),
    );
  }
}
