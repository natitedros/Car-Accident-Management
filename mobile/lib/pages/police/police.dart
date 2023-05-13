import 'dart:async';
import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:car_accident_management/pages/police/police_profile.dart';
import 'package:car_accident_management/pages/police/police_home.dart';
import 'package:car_accident_management/pages/police/police_cases.dart';
import 'package:car_accident_management/pages/login.dart';
import 'package:car_accident_management/datamodel.dart';
import 'package:geolocator/geolocator.dart';


class PolicePage extends StatefulWidget {
  final returenData data;
  const PolicePage({Key? key, required this.data}) : super(key: key);

  @override
  _PolicePageState createState() => _PolicePageState();
}

class _PolicePageState extends State<PolicePage> {
  int index = 0;
  String title0 = "Home";
  String title1 = "Cases";
  String title2 = "Profile";
  String mainTitle = "Home";
  List<returenCases> cases = [];
  late final screens = [];

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
      for (var i = 0; i < temp['cases'].length; i++) {
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
  Future<void> initializeNearby() async{
    Position? pos = await getLocation();
    if (pos != null){
      List<returenCases> temp = await fetchCases(pos);
      setState(() {
        cases = temp;
          screens.add(PoliceHomePage(data: widget.data, cases: cases));
          screens.add(PoliceCasesPage(data: widget.data));
          screens.add(PoliceProfilePage(data: widget.data));
      });
    }
  }


  @override
  void initState(){
    super.initState();
    initializeNearby();
    Timer timer = Timer.periodic(Duration(seconds: 30), (timer) async {
      Position? pos = await getLocation();
      if (pos != null){
        List<returenCases> temp = await fetchCases(pos);
        if (temp.length > cases.length){
          bool isallowed = await AwesomeNotifications().isNotificationAllowed();
          if (!isallowed) {
            //no permission of local notification
            AwesomeNotifications().requestPermissionToSendNotifications();
          }else{
            //show notification
            AwesomeNotifications().createNotification(
                content: NotificationContent( //simple notification
                  id: 123,
                  channelKey: 'basic', //set configuration with key "basic"
                  title: 'Accident Near You!',
                  body: 'There has been a crash near you! Check feed for info.',
                  largeIcon: 'asset://assets/logo.png',
                )
            );
          }
        }
        setState(() {
          cases = temp;
          screens[0] = PoliceHomePage(data: widget.data, cases: cases);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 3,
          title: Text(
            mainTitle,
            style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 15.0),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Color(0xFFFFC107),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                      (Route<dynamic> route) => false,
                );
              },
            )
          ],
        ),
        body: (screens.isEmpty) ? const Center(child: Text("Loading...")) : screens[index],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              indicatorColor: Colors.white,
              labelTextStyle: MaterialStateProperty.all(
                TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              )),
          child: NavigationBar(
              height: 60,
              backgroundColor: Colors.white,
              elevation: 5,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              selectedIndex: index,
              onDestinationSelected: (index) =>
                  setState(() {
                    this.index = index;
                    if (index == 0){
                      mainTitle = title0;
                    }
                    else if (index == 1){
                      mainTitle = title1;
                    }
                    else if (index == 2){
                      mainTitle = title2;
                    }
                  } ),
              destinations: [
                NavigationDestination(
                    icon: Icon(
                      Icons.home_outlined,
                      color: Color(0xFFAFAFAF),
                    ),
                    selectedIcon: Icon(
                      Icons.home_outlined,
                      color: Color(0xFF2CACE7),
                    ),
                    label: 'Home'),

                NavigationDestination(
                    icon: Icon(
                      Icons.file_copy_outlined,
                      color: Color(0xFFAFAFAF),
                    ),
                    selectedIcon: Icon(
                      Icons.file_copy_outlined,
                      color: Color(0xFF3AD425),
                    ),
                    label: 'Cases'),
                NavigationDestination(
                    icon: Icon(
                      Icons.person_outline_rounded,
                      color: Color(0xFFAFAFAF),
                    ),
                    selectedIcon: Icon(
                      Icons.person_outline_rounded,
                      color: Color(0xFFFFC107),
                    ),
                    label: 'Profile'),
              ]),
        ),
      );
}
