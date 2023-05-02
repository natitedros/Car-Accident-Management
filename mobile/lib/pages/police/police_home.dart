import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../datamodel.dart';
import '../case_info_layout.dart';

class PoliceHomePage extends StatefulWidget {
  final returenData data;
  const PoliceHomePage({Key? key, required this.data}) : super(key: key);
  @override
  _PoliceHomePageState createState() => _PoliceHomePageState();
}

class _PoliceHomePageState extends State<PoliceHomePage> {

  List<returenCases> cases = [];
  Future<Position?> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Cannot get the user's location");
        return null;
      }
    }
    Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return pos;
  }

  Future<List<returenCases>> fetchCases(Position? pos) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json'
    };
    final url = Uri.parse(
        'https://adega.onrender.com/police/nearme');
    var body = {
      "location": {
        "coordinates": [pos?.longitude, pos?.latitude]
      }
    };
    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);
    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    Map temp = jsonDecode(
        resBody); // accepts the data from the server and maps it onto temp

    final cases = <returenCases>[];

    if (res.statusCode == 200 ||
        res.statusCode == 201 ||
        res.statusCode == 300) {
      for (var i = 0; i < temp['cases'].length; i++){
        returenCases singleCase = returenCases(
          location: Location(
              type: temp['cases'][i]['location']['type'],
              coordinates: temp['cases'][i]['location']['coordinates']
          ),
          car: CarSpec(
              name: temp['cases'][i]['carName'],
              model: temp['cases'][i]['carModel'],
              color: temp['cases'][i]['carColor'],
              plateNumber: temp['cases'][i]['carPlateNumber']
          ),
          driver: DriverInfo(
              name: temp['cases'][i]['driverName'],
              phoneNumber: temp['cases'][i]['driverPhoneNumber']
          ),
          images: temp['cases'][i]['images'],
          id: temp['cases'][i]['_id'],
          createdAt: temp['cases'][i]['createdAt'],
          status: temp['cases'][i]['status'],
          handlerId: temp['cases'][i]['handlerId'],
          subjectId: temp['cases'][i]['subjectId'],
          severity: temp['cases'][i]['severity'],

        );
        cases.add(singleCase);
      }
      return cases;
    } else {
      return [];
    }
  }
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
            ElevatedButton(onPressed: () async{
              Position? pos = await getLocation();
              if (pos != null){
                List<returenCases> temp = await fetchCases(pos);
                setState(() {
                  cases = temp;
                });
              }
            }, child: Text("Refresh")),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                  child: (cases.isEmpty) ? const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "No accidents near you, try refreshing...",
                      style: TextStyle(
                          fontSize: 17
                      ),
                    ),
                  ):ListView.builder(
                      itemCount: cases.length,
                      itemBuilder: (context, index) {
                        return CaseInfoLayout(
                          child: cases![index],
                          data: widget.data,
                        );
                      })),
            )
          ],
        )
    );
  }
}
