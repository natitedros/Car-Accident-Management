import 'dart:convert';

import 'package:car_accident_management/datamodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  Future<bool> updateVerdict(String id, String verdict) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json'
    };
    var body = {
      "verdict" : verdict,
    };
    final url = Uri.parse(
        'https://adega.onrender.com/police/mycases/update/$id');
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF3AD425)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 3,
        title: const Text(
          'Verdict',
          style: TextStyle(color: Color(0xFF3AD425), fontSize: 15.0),
        ),
        centerTitle: true,
      ),
      body: Column(
          children: [
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
            ElevatedButton(onPressed: () async {
              setState(() {
                updateBtn = 'Updating...';
              });
              bool isUpdated = await updateVerdict('${widget.singleCase?.id}', verdict.text);
              if (isUpdated){
                setState(() {
                  updateBtn = 'Done';
                });
              }
              updateBtn = 'Try again';

            }, child: Text(updateBtn))
          ],
        ),
    );
  }
}
