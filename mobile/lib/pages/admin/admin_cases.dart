import 'package:flutter/material.dart';
import 'package:car_accident_management/pages/case_info_layout.dart';

import '../../datamodel.dart';

class AdminCasesPage extends StatefulWidget {
  final returenData data;
  const AdminCasesPage({Key? key, required this.data}) : super(key: key);

  @override
  _AdminCasesPageState createState() {
    return _AdminCasesPageState();
  }
}

class _AdminCasesPageState extends State<AdminCasesPage> {
  // perform GET REQUEST here using the id as the parameter and save the incoming data to the list below

  final List _cases = ['case1', 'case2', 'case3', 'case4', 'case5', 'case6'];

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
              itemCount: _cases.length,
              itemBuilder: (context, index) {
                return CaseInfoLayout(
                  child: _cases[index],
                );
              })),
    );
  }
}
