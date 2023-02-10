import 'package:car_accident_management/pages/casedetails.dart';
import 'package:car_accident_management/pages/changepassword.dart';
import 'package:flutter/material.dart';

class CaseInfoLayout extends StatelessWidget {
  final String child;

  CaseInfoLayout({required this.child});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 233, 233, 233),
              blurRadius: 2.0, // soften the shadow
              spreadRadius: 1.0, //extend the shadow
              offset: Offset(
                0.0, // Move to right 5  horizontally
                5.0, // Move to bottom 5 Vertically
              ),
            )
          ],
        ),
        height: 70,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 0),
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CaseDetailPage()),
                      // (Route<dynamic> route) => false,
                    );
                  },
                  child: Text(child,
                      style: TextStyle(
                          color: Color(0xFFAFAFAF),
                          decoration: TextDecoration.underline))),
            ),
            SizedBox(width: width * 0.55),
            Text('open', style: TextStyle(color: Color(0xFF3AD425)))
          ],
        ),
      ),
    );
  }
}
