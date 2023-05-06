import 'package:flutter/material.dart';
import '../../datamodel.dart';
import '../case_info_layout.dart';

class PoliceHomePage extends StatefulWidget {
  final returenData data;
  final List<returenCases> cases;
  const PoliceHomePage({Key? key, required this.data, required this.cases}) : super(key: key);
  @override
  _PoliceHomePageState createState() => _PoliceHomePageState();
}

class _PoliceHomePageState extends State<PoliceHomePage> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Accidents Near You",
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                  child: (widget.cases.isEmpty) ? const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "No accidents near you! It's a good day...",
                      style: TextStyle(
                          fontSize: 17
                      ),
                    ),
                  ):ListView.builder(
                      itemCount: widget.cases.length,
                      itemBuilder: (context, index) {
                        return CaseInfoLayout(
                          child: widget.cases![index],
                          data: widget.data,
                        );
                      })),
            )
          ],
        )
    );
  }
}
