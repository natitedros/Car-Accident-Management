import 'package:car_accident_management/pages/car_info_layout.dart';
import 'package:flutter/material.dart';
import '../../datamodel.dart';

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

    final url = Uri.parse(
        'https://adega.onrender.com/driver/mycars/$id');
    http.Response response = await http.get(url);
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
              print("z is ${z?[0].id}");
              print(z?.length);
              return Container(
                  alignment: Alignment.center,
                  child: ListView.builder(
                      itemCount: z?.length,
                      itemBuilder: (context, index) {
                        return CarInfoLayout(
                          child: z![index].name!,
                        );
                      }));
            }
            return Center(child: Text("loading"));
          }
              ),
        ));
    // );
  }
}
