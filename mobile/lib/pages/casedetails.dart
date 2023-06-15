import 'dart:convert';

import 'package:car_accident_management/pages/display_images.dart';
import 'package:car_accident_management/pages/token_checker.dart';
import 'package:car_accident_management/pages/update_verdict.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../datamodel.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    Uri googleUrl =
    Uri.parse('https://www.google.com/maps/search/?api=1&query=$longitude,$latitude');
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
    String? token = await TokenService().readToken();

    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json',
      'Authorization' : 'Bearer $token'

    };
    var body = {
      "policeId": handlerId,
      "caseId": caseId
    };
    final url = Uri.parse('${dotenv.env['STARTING_URI']}/police/cases/assign');
    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = jsonEncode(body);
    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    if (res.statusCode == 200 || res.statusCode == 201 || res.statusCode == 300) {
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
      "status": 'closed'
    };
    final url =
    Uri.parse('https://adega.onrender.com/police/mycases/update/$caseId');
    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = jsonEncode(body);
    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    if (res.statusCode == 200 || res.statusCode == 201 || res.statusCode == 300) {
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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              Card(
                child: ListTile(
                  title: const Text(
                    'Date',
                    style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 20.0),
                  ),
                  subtitle: Text(
                    "${caseTime.day}/${caseTime.month}/${caseTime.year}",
                    style: TextStyle(color: Color(0xFF3AD425), fontSize: 15.0),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text(
                    'Time',
                    style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 20.0),
                  ),
                  subtitle: Text(
                    "${caseTime.hour}:${caseTime.minute}",
                    style: TextStyle(color: Color(0xFF3AD425), fontSize: 15.0),textAlign: TextAlign.right,
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(
                    'Severity',
                    style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 20.0),
                  ),
                  subtitle: Text(
                    "${widget.singleCase?.severity}",
                    style: TextStyle(color: Color(0xFF3AD425), fontSize: 15.0),textAlign: TextAlign.right,
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(
                    'Car',
                    style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 20.0),
                  ),
                  subtitle: Text(
                    "${widget.singleCase?.car?.name}-${widget.singleCase?.car?.model}-${widget.singleCase?.car?.color}",
                    style: TextStyle(color: Color(0xFF3AD425), fontSize: 15.0),textAlign: TextAlign.right,
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(
                    'Plate Number',
                    style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 20.0),
                  ),
                  subtitle: Text(
                    "${widget.singleCase?.car?.plateNumber}",
                    style: TextStyle(color: Color(0xFF3AD425), fontSize: 15.0),textAlign: TextAlign.right,
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(
                    'Driver',
                    style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 20.0),
                  ),
                  subtitle: Text(
                    "${widget.singleCase?.driver?.name}",
                    style: TextStyle(color: Color(0xFF3AD425), fontSize: 15.0),textAlign: TextAlign.right,
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(
                    'Phone Number',
                    style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 20.0),
                  ),
                  subtitle: Text(
                    "${widget.singleCase?.driver?.phoneNumber}",
                    style: TextStyle(color: Color(0xFF3AD425), fontSize: 15.0),textAlign: TextAlign.right,
                  ),
                ),
              ),

              SizedBox(
                height: height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      elevation: 3,
                      backgroundColor: Color(0xFF3AD425),
                    ),
                    onPressed: () {
                      MapUtils.openMap(
                          widget.singleCase?.location?.coordinates?[0],
                          widget.singleCase?.location?.coordinates?[1]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: const Text("See on map",
                        style: TextStyle(fontSize: 15.0)),
                    ),

                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: (widget.singleCase?.images) != null
                        ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        elevation: 3,
                        backgroundColor: Color(0xFF3AD425),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DisplayImagesPage(
                              images: widget.singleCase?.images,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: const Text('Crash Images'),
                      ),
                    )
                        : null,
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                child: (widget.singleCase?.status == 'open' &&
                    widget.user?.role == "police")
                    ? TextButton(
                  onPressed: () async {
                    if (assignBtn == "Assign Self" ||
                        assignBtn == "Try again") {
                      setState(() {
                        assignBtn = "Assigning...";
                      });
                      bool isAssigned = await assignSelf(
                          "${widget.singleCase?.id}",
                          "${widget.user?.id}");
                      if (isAssigned) {
                        setState(() {
                          assignBtn = "Done";
                        });
                      } else {
                        assignBtn = "Try again";
                      }
                    }
                  },
                  child: Text(assignBtn,style: const TextStyle(
                    color: Color(0xFF3AD425), decoration: TextDecoration.underline,
                  ),),
                )
                    : Container(
                  child: (widget.user?.role != "police")
                      ? Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Column(
                      children: <Widget>[
                       const Text(
                          "Verdict",
                          style: TextStyle(
                              color: Color(0xFFBEBEBE), fontSize: 20.0), textAlign: TextAlign.center,
                        ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: (widget.singleCase?.verdict != null) ? Text(
                        "${widget.singleCase?.verdict}",
                        style: TextStyle(
                            color: Color(0xFFBEBEBE), fontSize: 15.0), textAlign: TextAlign.left,
                      ) : Text("Verdict still in progress..."),
                    )
                    ]
                    ),
                  )
                      : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(17.0),
                child: Container(
                  child: (widget.singleCase?.status == 'pending' &&
                      widget.user?.role == 'police')
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateVerdictPage(
                                singleCase: widget.singleCase,
                              ),
                            ),
                          );
                        },


                        child: const Text('UPDATE',
                          style: TextStyle(
                            color: Color(0xFF3AD425),
                            decoration: TextDecoration.underline,
                          ),),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (closeBtn == 'CLOSE') {
                            setState(() {
                              closeBtn = 'Closing...';
                            });
                            bool isClosed =
                            await closeCase('${widget.singleCase?.id}');
                            if (isClosed) {
                              setState(() {
                                closeBtn = 'Done';
                              });
                            }
                          }
                        },

                        child: Text(closeBtn,
                          style: TextStyle(
                            color: Color(0xFF3AD425),
                            decoration: TextDecoration.underline,
                          ),),
                      ),
                    ],
                  )
                      : null,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
