import 'package:flutter/material.dart';
import 'package:car_accident_management/pages/case_info_layout.dart';

class DriverCasesPage extends StatefulWidget {
  @override
  _DriverCasesPageState createState() => _DriverCasesPageState();
}

class _DriverCasesPageState extends State<DriverCasesPage> {
  final List _cars = ['case1', 'case2', 'case3', 'case4', 'case5', 'case6'];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        title: Text(
          'Cases',
          style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 15.0),
        ),
        centerTitle: true,
      ),
      body: Container(
          alignment: Alignment.center,
          child: ListView.builder(
              itemCount: _cars.length,
              itemBuilder: (context, index) {
                return CaseInfoLayout(
                  child: _cars[index],
                );
              })),
    );
  }
}
