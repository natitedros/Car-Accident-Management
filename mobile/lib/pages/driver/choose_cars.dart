import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../datamodel.dart';
import 'package:http/http.dart' as http;

import 'camera_page.dart';

class ChooseCars extends StatelessWidget {
  final List<returenCars>? cars;
  final Position position;
  final returenData data;
  final bool isUpload;
  const ChooseCars({Key? key, required this.isUpload, required this.cars, required this.position, required this.data}) : super(key: key);

  static const String _title = 'Which car are you in?';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text(_title),
          backgroundColor: Color(0xFF2CACE7),
        ),
        body: ChooseCarsPage(carList: cars, position: position, data: data, isUpload: isUpload),
      );
  }
}

class ChooseCarsPage extends StatefulWidget {
  final List<returenCars>? carList;
  final Position position;
  final returenData data;
  final bool isUpload;
  const ChooseCarsPage({Key? key,
    required this.carList,
    required this.position,
    required this.data,
    required this.isUpload
  }) : super(key: key);

  @override
  State<ChooseCarsPage> createState() => _ChooseCarsPageState();
}
class _ChooseCarsPageState extends State<ChooseCarsPage> {
  int _selectedIndex = 0;
  String successMsg = '';
  String btnTxt = '';

  @override
  void initState(){
    btnTxt = (widget.isUpload) ? 'Take Photo' : 'Call Now';
  }

  Future<String?> createCase(Position pos, returenCars? car, returenData data) async {

    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json'
    };

    var url = Uri.parse('https://adega.onrender.com/driver/minor/addcase');
    var body = {
      "location": {
        "type": "Point",
        "coordinates": [pos.longitude, pos.latitude]
      },
      "subjectId": "${data.id}",
      "status": "open",
      "severity": "minor",
      "carName": "${car?.name}",
      "carModel": "${car?.model}",
      "carColor": "${car?.color}",
      "carPlateNumber" : "${car?.plateNumber}",
      "driverName": "${data?.name}",
      "driverPhoneNumber" : "${data?.phoneNumber}"

    };
    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);
    print(req.body);
    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    Map temp = jsonDecode(
        resBody);
    if (res.statusCode == 200 ||
        res.statusCode == 201 ||
        res.statusCode == 300) {
      print("Case successfully created!");
      return temp['case'];
    } else {
      print("Bad request!");
      return null;
    }

  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(child: Text("Choose from the list below", style: TextStyle(
          fontSize: 20
        ),)),
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.carList?.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: Text(
                    '${widget.carList?[index].name} - ${widget.carList?[index].model} - ${widget.carList?[index].plateNumber}',
                    style: TextStyle(
                        color: _selectedIndex == index ? Color(0xFF2CACE7) : Color(0xFFAFAFAF),
                        fontSize: 17.0)
                ),
                selected: index == _selectedIndex,
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                elevation: 3,
                backgroundColor: Color(0xFF2CACE7),
              ),
              onPressed: () async {
                if (widget.isUpload){
                      String? caseId = await createCase(widget.position, widget.carList?[_selectedIndex], widget.data);
                      if (caseId != null){
                            await availableCameras().then((value) => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => CameraPage(cameras: value, caseId: caseId))));
                      }
                }
                else{
                  if (btnTxt == "Back"){
                    Navigator.of(context).pop();
                  }
                  else{
                    setState(() {
                      btnTxt = "Calling...";
                    });
                    String? isComplete = await createCase(widget.position, widget.carList?[_selectedIndex], widget.data);
                    if (isComplete != null){
                      setState(() {
                        btnTxt = "Back";
                        successMsg = "Police Notified! You will receive a notification when police is on its way...";
                      });
                    }
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "$btnTxt"
                ),
              )
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text("$successMsg"),
          ),
        )
      ],
    );
  }
}
