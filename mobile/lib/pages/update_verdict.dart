import 'dart:convert';

import 'package:car_accident_management/datamodel.dart';
import 'package:car_accident_management/pages/token_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UpdateVerdictPage extends StatefulWidget {
  final returenCases? singleCase;
  const UpdateVerdictPage({Key? key, required this.singleCase}) : super(key: key);

  @override
  State<UpdateVerdictPage> createState() => _UpdateVerdictPageState();
}

class _UpdateVerdictPageState extends State<UpdateVerdictPage> {
  TextEditingController verdict = TextEditingController();

  String updateBtn = 'UPDATE';
  Future<bool> updateVerdict(String? id, String verdict) async {
    print(widget.singleCase?.id);
    print(verdict);
    String? token = await TokenService().readToken();
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json',
      'Authorization' : 'Bearer $token'
    };
    var body = {
      "verdict" : verdict,
    };
    final url = Uri.parse(
        '${dotenv.env['STARTING_URI']}/police/mycases/update/$id');
    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = jsonEncode(body);
    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    print(res.statusCode);
    if (res.statusCode == 200 || res.statusCode == 201 || res.statusCode == 300){
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    if (widget.singleCase?.verdict != null){
      verdict.text = '${widget.singleCase?.verdict}';
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(0xFF3AD425),
        elevation: 3,
        title: const Text(
          'Verdict',
          style: TextStyle(fontSize: 15.0),
        ),
        centerTitle: true,
      ),
      body: Center(

        child: Column(
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Input the verdict below...'),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: verdict,
                  keyboardType: TextInputType.multiline,
                  maxLines: 8,
                  decoration: const InputDecoration(
                      hintText: "Enter verdict here",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.green)
                      )
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    elevation: 3,
                    backgroundColor: Color(0xFF3AD425),
                  ),
                  onPressed: () async {
                setState(() {
                  updateBtn = 'Updating...';
                });
                bool isUpdated = await updateVerdict(widget.singleCase?.id, verdict.text);
                if (isUpdated){
                  setState(() {
                    updateBtn = 'UPDATE';
                  });
                }
                else{
                  updateBtn = 'Try again';
                }

              }, child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(updateBtn),
              ))
            ],
          ),
      ),
    );
  }
}
