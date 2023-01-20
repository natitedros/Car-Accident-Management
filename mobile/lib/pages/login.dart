import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../datamodel.dart';

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

  Future<DataModel?> submitData(String email, String password) async {
    var response = await http.post(Uri.https('reqres.in', '/api/users'), body: {
      "email": email,
      "password": password,
    });
    var data = response.body;
    print(data);

    if (response.statusCode == 201) {
      String responseString = response.body;
      dataModelFromJson(responseString);
    } else {
      return null;
    }
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

                    DataModel? data = await submitData(email, password);

                    setState(() {
                      _dataModel = data;
                    });
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => DriverPage()),
                      (Route<dynamic> route) => false,
                    );
                  },
                )),
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
