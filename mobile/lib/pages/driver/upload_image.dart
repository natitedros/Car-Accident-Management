import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../token_checker.dart';

class UploadImagePage extends StatefulWidget {
  final List<XFile> images;
  final String caseId;
  const UploadImagePage({Key? key, required this.images, required this.caseId}) : super(key: key);

  @override
  State<UploadImagePage> createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  String uploadBtn = "Upload";
  Future<bool> uploadImage() async {

    String? token = await TokenService().readToken();

    var request = http.MultipartRequest(
        'POST', Uri.parse('${dotenv.env['STARTING_URI']}/driver/caseimages/${widget.caseId}'));
    request.headers['Authorization'] = 'Bearer $token';

    for(var i = 0; i < widget.images.length; i++){
      var path = File(widget.images[i].path).path;
      request.files.add(
          await MultipartFile.fromPath(
            'images',
              path,
            filename: path.split('/').last
          )
      );
    }
    var res = await request.send();
    if (res.statusCode == 200){
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('Upload Images')
      ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              itemCount: widget.images.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                crossAxisCount: 2,
              ),

              itemBuilder: (context, index) {
                return Image.file( File(widget.images[index].path));
              }),
        ),
      floatingActionButton: FloatingActionButton.extended(onPressed: ()async{
        if(uploadBtn == "Done"){
          int count = 0;
          Navigator.of(context).popUntil((_) => count++ >= 3);
        }
        else{
          setState(() {
            uploadBtn = "Uploading...";
          });
          if (await uploadImage()){
            setState(() {
              uploadBtn = "Done";
            });
          }
          else {
            setState(() {
              uploadBtn = "Try Again";
            });
          }
        }
      }, label: Text(uploadBtn)),
    );
  }
}

