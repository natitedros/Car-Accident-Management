import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../datamodel.dart';
// import 'package:requests/requests.dart';

import 'package:car_accident_management/pages/signup.dart';
import 'package:car_accident_management/pages/driver/driver.dart';

void main() => runApp(const Login());

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  // static const String _title = 'Sample App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: _title,
      home: Scaffold(
        // appBar: AppBar(title: const Text(_title)),
        body: const LoginStateful(),
      ),
      theme: ThemeData(
          fontFamily: 'Feather',
          textTheme: TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
          ).apply(
            bodyColor: Color(0xFFAFAFAF),
          )),
    );
  }
}

class LoginStateful extends StatefulWidget {
  const LoginStateful({Key? key}) : super(key: key);

  @override
  State<LoginStateful> createState() => _LoginStatefulState();
}

class _LoginStatefulState extends State<LoginStateful> {
  DataModel? _dataModel;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? errorEmail =
      ""; // the error message that shows when the user inputs wrong information
  String? errorPassword = "";

  Future<returenData> submittData(String email, String password) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json'
    };

    var url = Uri.parse('https://adega.onrender.com/login');
    var body = {'email': email, 'password': password};

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);
    log(req.body);
    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    Map temp = jsonDecode(
        resBody); // accepts the data from the server and maps it onto temp

    if (res.statusCode == 200 ||
        res.statusCode == 201 ||
        res.statusCode == 300) {
      returenData data = returenData(
          name: temp['user']['name'],
          email: temp['user']['email'],
          role: temp['user']['role']);
      print(resBody);
      print("user is ${temp['user']['name']}");
      print("user is ${temp['user']['email']}");
      print("user is a ${temp['user']['role']}");

      return data;
    } else {
      print("error is ${temp['errors']}");
      returenData data = returenData(errors: Map.from(temp['errors']));
      // print("Passed");
      return data;
    }
  }

  Future<DataModel?> submitData(String email, String password) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json'
    };

    var url = Uri.parse('https://adega.onrender.com/login');
    var body = {'email': email, 'password': password};

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);
    log(req.body);
    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    Map temp = jsonDecode(
        resBody); // accepts the data from the server and maps it onto temp
    log(req.toString());
    log(res.toString());
    log(res.statusCode.toString());
    if (res.statusCode == 200 ||
        res.statusCode == 201 ||
        res.statusCode == 300) {
      print(resBody); // prints the whole result accepted from temp
      print(temp['user']['name']);
      // takes the result from temp and displays the output as a string
      DataModel data = DataModel(
        name: temp['user']['name'],
      );
      return data;
    } else {
      log(resBody);
      print(temp['errors']);
      // errorMessage = temp['errors']['email'];
    }
    return null;

    // var response = await http.post(Uri.https('reqres.in', '/api/users'), body: {
    //   "email": email,
    //   "password": password,
    // });
    // var data = response.body;
    // print(data);

    // if (response.statusCode == 201) {
    //   String responseString = response.body;
    //   dataModelFromJson(responseString);
    // } else {
    //   return null;
    // }
    // var r = await Requests.post(
    //   'https://adega.onrender.com/login',
    //   body: {
    //     'email': email,
    //     'password': password,
    //   },
    // );

    // r.raiseForStatus();
    // dynamic json = r.json();
    // print(json!['email']);
    // print(r.json());

    // var headers = {
    //   'Content-Type': 'application/json',
    //   'Cookie':
    //       'jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzY2ZkMWM1M2M4M2NjNGU3ZDBjNzU5ZiIsImlhdCI6MTY3NDU3MTAyMywiZXhwIjoxNjc0ODMwMjIzfQ.Un4CcfQiZK-YFZ5YSX-Idq4FihEFKXE0iimyWQGhBE0'
    // };
    // var request =
    //     http.Request('POST', Uri.parse('https://adega.onrender.com/login'));
    // request.body =
    //     json.encode({"email": "nati@google.com", "password": "1234567"});
    // request.headers.addAll(headers);
    // var response = await request.send();
    // log(request.toString());
    // print(response);
    // // http.StreamedResponse response = await request.send();

    // if (response.statusCode == 200) {
    //   print(await response.stream.bytesToString());
    // } else {
    //   print(response.reasonPhrase);
    // }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 5),
              child: Image.asset(
                'assets/logo.png',
                width: 150,
                height: 150,
              ),
            ),

            SizedBox(height: height * 0.01),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              // child: const Text(
              //   'Sign in',
              //   style: TextStyle(fontSize: 20),
              // )
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
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
                  labelText: 'email',
                  labelStyle: TextStyle(
                    color: Color(0xFFAEAEAE),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                "$errorEmail",
                style: TextStyle(color: Colors.red, fontSize: 10.0),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(30, 5, 30, 0),
              child: TextField(
                style: TextStyle(fontSize: 15.0),
                obscureText: true,
                controller: passwordController,
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
                  labelText: 'password',
                  labelStyle: TextStyle(
                    color: Color(0xFFAEAEAE),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Center(
                child: Text(
              "$errorPassword",
              style: TextStyle(color: Colors.red, fontSize: 10.0),
            )),

            // TextButton(
            //   onPressed: () {
            //     //forgot password screen
            //   },
            //   child: const Text('Forgot Password',),
            // ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
                height: height * 0.09,
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                child: ElevatedButton(
                    child: const Text('LOG IN'),

                    // style: ButtonStyle(
                    //   shadowColor: MaterialStatePropertyAll<Color>(Colors.pink),
                    //     backgroundColor: MaterialStatePropertyAll<Color>(
                    //       Color(0xFF2CACE7),
                    //     ),
                    //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    //         RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(10.0),
                    //         )
                    //     )
                    // ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                      backgroundColor: Color(0xFF2CACE7),
                    ),
                    onPressed: () async {
                      String email = emailController.text;
                      String password = passwordController.text;

                      returenData data = await submittData(email, password);
                      if (data.errors != null) {
                        setState(() {
                          // _dataModel = data;

                          // here depending on the return value "data" the system recognizes
                          // whether the user is a driver,police or admin and notify user if email or password is wrong
                          if (data.errors!['email'] != null) {
                            errorEmail = data.errors!['email'];
                            errorPassword = data.errors!['password'];
                          }
                        });
                      } else if (data.role == 'driver') {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => DriverPage()),
                          (Route<dynamic> route) => false,
                        );
                      } else if (data.role == 'police') {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => DriverPage()),
                          (Route<dynamic> route) => false,
                        );
                      } else if (data.role == 'admin') {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => DriverPage()),
                          (Route<dynamic> route) => false,
                        );
                      }
                    })),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 15, 40, 0),
              child: Center(
                child: Text(
                  "OR",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFFAFAFAF),
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                const Text(
                  'Don\'t have account?',
                  style: TextStyle(
                    color: Color(0xFFAFAFAF),
                  ),
                ),
                SizedBox(width: 10.0),
                TextButton(
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      color: Color(0xFF2CACE7),
                    ),
                  ),
                  onPressed: () {
                    //signup screen
                    // Navigator.pushReplacementNamed(context, '/signup');

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Signup()),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            SizedBox(height: height * 0.05),
            Center(
              child: Text(
                "By signing up, you agree to our Terms and Privacy Policy",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFAFAFAF),
                ),
              ),
            ),
          ],
        ));
  }
}
