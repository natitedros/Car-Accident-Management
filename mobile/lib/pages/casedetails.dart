import 'dart:convert';

import 'package:car_accident_management/pages/update_verdict.dart';

import '../../datamodel.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class MapUtils {

  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    Uri googleUrl = Uri.parse('https://www.google.com/maps/search/?api=1&query=$longitude,$latitude');
    if (await canLaunchUrl(googleUrl)) {
      await launchUrl(googleUrl);
    } else {
      throw 'Could not open the map!';
    }
  }
}

class CaseDetailPage extends StatefulWidget {
  final returenCases? singleCase;
  final returenData? user;
  CaseDetailPage({Key? key, required this.singleCase, this.user}) : super(key: key);

  @override
  State<CaseDetailPage> createState() => _CaseDetailPageState();
}

class _CaseDetailPageState extends State<CaseDetailPage> {
  Future<bool> assignSelf(String caseId, String handlerId) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json'
    };
    var body = {
      "policeId" : handlerId,
      "caseId" : caseId
    };
    final url = Uri.parse(
        'https://adega.onrender.com/police/cases/assign');
    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = jsonEncode(body);
    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    if (res.statusCode == 200 || res.statusCode == 201 || res.statusCode == 300){
      return true;
    }
    return false;
  }
  Future<bool> closeCase(String caseId) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json'
    };
    var body = {
      "status" : 'closed'
    };
    final url = Uri.parse(
        'https://adega.onrender.com/police/update/$caseId');
    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = jsonEncode(body);
    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    if (res.statusCode == 200 || res.statusCode == 201 || res.statusCode == 300){
      return true;
    }
    return false;
  }

  String assignBtn = "Assign Self";
  String closeBtn = 'CLOSE';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    DateTime caseTime = DateTime.parse("${widget.singleCase?.createdAt}");


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF3AD425)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 3,
        title: const Text(
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
          const Text("Accident time:",
              style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 25.0)),
          Text("${caseTime.day}/${caseTime.month}/${caseTime.year}  at   ${caseTime.hour}:${caseTime.minute}",
              style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 20.0)),
          SizedBox(
            height: height * 0.02,
          ),
          Text("Severity: ${widget.singleCase?.severity}",
              style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 20.0)),
          Text("Car: ${widget.singleCase?.car?.name}-${widget.singleCase?.car?.model}-${widget.singleCase?.car?.color}",
              style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 20.0)),
          Text("Plate Number: ${widget.singleCase?.car?.plateNumber}",
              style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 20.0)),
          Text("Driver: ${widget.singleCase?.driver?.name}  - ${widget.singleCase?.driver?.phoneNumber}",
              style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 20.0)),
          SizedBox(
            height: height * 0.02,
          ),
          ElevatedButton(
              onPressed: (){
                print(widget.singleCase?.location?.coordinates?[0]);
                print(widget.singleCase?.location?.coordinates?[1]);
                MapUtils.openMap(widget.singleCase?.location?.coordinates?[0], widget.singleCase?.location?.coordinates?[1]);
              },
              child: const Text("See on map")),
          SizedBox(
            height: height * 0.05,
          ),
          Container(
            child: (widget.singleCase?.status == 'open' && widget.user?.role == "police") ?
                ElevatedButton(
                  onPressed: () async {
                    if (assignBtn == "Assign Self" || assignBtn == "Try again"){
                      setState(() {
                        assignBtn = "Assigning...";
                      });
                      bool isAssigned = await assignSelf("${widget.singleCase?.id}", "${widget.user?.id}");
                      if (isAssigned){
                        setState(() {
                          assignBtn = "Done";
                        });
                      }else{
                        assignBtn = "Try again";
                      }
                    }
                  },
                  child: Text(assignBtn),
                ) :
                Text("Verdict: ${widget.singleCase?.verdict}",
                    style: TextStyle(color: Color(0xFFBEBEBE), fontSize: 20.0))
          ),
          Padding(
            padding: const EdgeInsets.all(17.0),
            child: Container(child: (widget.singleCase?.status =='pending' && widget.user?.role == 'police') ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              UpdateVerdictPage( singleCase: widget.singleCase,)
                      ),
                        // (Route<dynamic> route) => false,
                      );
                    }, style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14), // <-- Radius
                      ),
                    ), child: const Text('UPDATE')),
                    ElevatedButton(onPressed: () async {
                      if (closeBtn == 'CLOSE'){
                        setState(() {
                          closeBtn = 'Closing...';
                        });
                        bool isClosed = await closeCase('${widget.singleCase?.id}');
                        if (isClosed){
                          setState(() {
                            closeBtn = 'Done';
                          });
                        }
                      }
                    }, style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14), // <-- Radius
                        ),
                      ), child: Text(closeBtn),
                    ),

                  ],
                ): null
            ),
          )
        ]),
      ),
    );
  }
}
