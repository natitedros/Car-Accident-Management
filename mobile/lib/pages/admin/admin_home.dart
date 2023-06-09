import 'dart:convert';
import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:car_accident_management/pages/admin/admin_user_details.dart';
import 'package:flutter/material.dart';
import '../../datamodel.dart';
import '../token_checker.dart';
import 'admin_create_police.dart';

class AdminHomePage extends StatefulWidget {
  final returenData data;
  const AdminHomePage({Key? key, required this.data}) : super(key: key);
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {

  TextEditingController emailController = TextEditingController();
  String? errorEmail = "";

  Future<returenData> searchUser(String email) async {
    String? token = await TokenService().readToken();
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json',
      'Authorization' : 'Bearer $token'
    };

    var url = Uri.parse('${dotenv.env['STARTING_URI']}/admin/search');
    var body = {'email': email};

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);
    log(req.body);
    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    Map temp = jsonDecode(
        resBody); // accepts the data from the server and maps it onto temp
    print(temp);
    if (res.statusCode == 200 ||
        res.statusCode == 201 ||
        res.statusCode == 300) {
      returenData data = returenData(
        name: temp['name'],
        email: temp['email'],
        phoneNumber: temp['phoneNumber'],
        role: temp['role'],
        id: temp['id'],
        caseNumber: temp['caseNumber'],
        isActive: temp['isActive']
      );
      return data;
    } else {
      returenData data = returenData(errors: Map.from(temp));
      return data;
    }
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(

      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Search any user here...",
              style: TextStyle(
                fontSize: 17
              ),
            ),
          SizedBox(height: height * 0.05),
            Row(
              children: [
                Expanded(
                  child: TextField(
                      style: TextStyle(fontSize: 15.0),
                      controller: emailController,
                      decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: Color(0xFFF5F5F5),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFE4E4E4),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF2CACE7),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Filter by email',
                      labelStyle: TextStyle(
                        color: Color(0xFFAEAEAE),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0),
                  child: IconButton(
                      onPressed: () async {
                        if (emailController.text == widget.data.email){
                          setState(() {
                            errorEmail = "You have entered your own account!";
                          });
                        }
                        else{

                          returenData userResult = await searchUser(emailController.text);
                          if (userResult.errors == null) {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    UserDetailsPage(data: userResult)),
                              // (Route<dynamic> route) => false,
                            );
                          }
                          else{
                            setState(() {
                              errorEmail = userResult.errors?['error'];
                            });
                          }
                        }
                      },
                      icon: Icon(
                        Icons.search_outlined,
                        color: Color(0xFFAFAFAF),
                        size: 35,
                      )),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            Center(
              child: Text(
                "$errorEmail",
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ),
            SizedBox(height: height * 0.02),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                          CreatePolicePage()
                  ),
                    // (Route<dynamic> route) => false,
                  );
                },
                child: const Text("Create Traffic Police Account")
            )
          ],
        ),

      ),

    );
  }
}
