import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:car_accident_management/pages/case_info_layout.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../../datamodel.dart';
import '../token_checker.dart';

class PoliceCasesPage extends StatefulWidget {
  final returenData data;
  const PoliceCasesPage({Key? key, required this.data}) : super(key: key);
  @override
  _PoliceCasesPageState createState() => _PoliceCasesPageState();
}

class _PoliceCasesPageState extends State<PoliceCasesPage> {
  Future<List<returenCases>?> fetchCases(String id) async {
    String? token = await TokenService().readToken();
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json',
      'Authorization' : 'Bearer $token'
    };
    final url = Uri.parse(
        '${dotenv.env['STARTING_URI']}/police/mycases/$id');
    var req = http.Request('GET', url);
    req.headers.addAll(headersList);
    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    // print(resBody);
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
            return const Center(child: Text('loading'));
          }),
        ));
  }
}
