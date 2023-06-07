import 'package:car_accident_management/pages/car_info_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../datamodel.dart';

import '../token_checker.dart';
import 'add_cars.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DriverCarsPage extends StatefulWidget {
  final returenData data;
  const DriverCarsPage({Key? key, required this.data}) : super(key: key);

  @override
  _DriverCarsPageState createState() => _DriverCarsPageState();
}

class _DriverCarsPageState extends State<DriverCarsPage> {
//data Type - List<returenCars>
  Future<List<returenCars>?> fetchCars(String id) async {
    String? token = await TokenService().readToken();
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json',
      'Authorization' : 'Bearer $token'
    };
    final url = Uri.parse(
        '${dotenv.env['STARTING_URI']}/driver/mycars/$id');
    http.Response response = await http.get(url, headers: headersList);
    Iterable resBody = jsonDecode(response.body);
    // accepts the data from the server and maps it onto temp
    try {
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 300) {
        List<returenCars> Cars = [];
        for (var singleCase in resBody) {
          Cars.add(returenCars(
              id: singleCase['_id'],
              name: singleCase['name'],
              model: singleCase['model'],
              plateNumber: singleCase['plateNumber'],
              ownerId: singleCase['ownerId'],
              region: singleCase['region']));
        }
        //We use teh array Cars to fill out the list cards
        return Cars;
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
          future: fetchCars("${widget.data.id}"),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<returenCars>? z = snapshot.data;

              return Container(
                  alignment: Alignment.center,
                  child: ListView.builder(
                      itemCount: z?.length,
                      itemBuilder: (context, index) {
                        return CarInfoLayout(
                          child: z![index].name!,
                        );
                      }),
              );
            }
            return Center(child: Text("loading..."));
          }
              ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFFCB3D2D),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) =>
                    AddCar(data: widget.data)
            ),
              // (Route<dynamic> route) => false,
            );
          },
          child: const Icon(Icons.add),
        )
    );
    // );
  }
}
