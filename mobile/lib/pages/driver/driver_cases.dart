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
  Future<List<returenCases>?> fetchCases() async {
    final url = Uri.parse(
        'https://adega.onrender.com/driver/mycases/63d0050fdd72e0a01b0958a2');
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
          Cases.add(returenCases(
              id: singleCase['_id'],
              status: singleCase['status'],
              subjectId: singleCase['subjectId'],
              createdAt: singleCase['createdAt'],
              location: loc));
        }
        //We use teh array Cases to fill out the listcards
        print(Cases[0].status);
        return Cases;
      }
    } catch (err) {
      print(err);
    }
  }

  final List _cases = ['case1', 'case2', 'case3', 'case4', 'case5', 'case6'];

  @override
  void initState() {
    super.initState();
    fetchCases();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(

        body: FutureBuilder(
          future: fetchCases(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<returenCases>? z = snapshot.data;
              print('z is ${z?[0].status}');
              print(z?.length);

              return Container(
                  alignment: Alignment.center,
                  child: ListView.builder(
                      itemCount: z?.length,
                      itemBuilder: (context, index) {
                        return CaseInfoLayout(
                          child: z![index].createdAt!,
                        );
                      }));
            }
            return Center(child: Text('loading'));
          }),
        ));
  }
}
