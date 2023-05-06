import 'package:flutter/material.dart';
import 'package:car_accident_management/pages/case_info_layout.dart';
import '../../datamodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DriverCasesPage extends StatefulWidget {
  final returenData data;
  const DriverCasesPage({Key? key, required this.data}) : super(key: key);
  @override
  _DriverCasesPageState createState() => _DriverCasesPageState();
}

class _DriverCasesPageState extends State<DriverCasesPage> {
  Future<List<returenCases>?> fetchCases(String id) async {
    final url = Uri.parse(
        'https://adega.onrender.com/driver/mycases/$id');
    http.Response response = await http.get(url);
    Iterable resBody = jsonDecode(response.body);
    // accepts the data from the server and maps it onto temp

    try {
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 300) {
        List<returenCases> Cases = [];
        for (var singleCase in resBody) {
          Location loc = Location(
              type: singleCase['location']['type'],
              coordinates: singleCase['location']['coordinates']);
          CarSpec car = CarSpec(
            name: singleCase['carName'],
            model: singleCase['carModel'],
            color: singleCase['carColor'],
            plateNumber: singleCase['carPlateNumber']
          );
          DriverInfo driver = DriverInfo(
            name: singleCase['driverName'],
            phoneNumber: singleCase['driverPhoneNumber']
          );
          List<dynamic> images = [];
          if (singleCase['images'] != null){
            images = singleCase['images'];
          }
          Cases.add(returenCases(
              id: singleCase['_id'],
              status: singleCase['status'],
              subjectId: singleCase['subjectId'],
              createdAt: singleCase['createdAt'],
              severity: singleCase['severity'],
              verdict: singleCase['verdict'],
              car: car,
              driver: driver,
              location: loc,
              images: images
          ));
        }
        //We use the array Cases to fill out the list cards
        return Cases;
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(

        body: FutureBuilder(
          future: fetchCases("${widget.data.id}"),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<returenCases>? z = snapshot.data;

              return Container(
                  alignment: Alignment.center,
                  child: (z != null && z.isEmpty) ? const Text(
                    "You don't have any cases to show",
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ):ListView.builder(
                      itemCount: z?.length,
                      itemBuilder: (context, index) {
                        return CaseInfoLayout(
                          child: z![index],
                          data: widget.data,
                        );
                      }));
            }
            return Center(child: Text('loading'));
          }),
        ));
  }
}
