import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UploadImagePage extends StatelessWidget {
  final List<XFile> images;
  const UploadImagePage({Key? key, required this.images}) : super(key: key);
  List<File> getPics(){
    List<File> pictures = [];
    for (XFile image in images){
      pictures.add(File(image.path));
    }
    return pictures;
  }
  void uploadImage() async {

    List<File> pictures = getPics();

    var request = http.MultipartRequest(
        'POST', Uri.parse('endpoint for uploading images'));

    final uploadList = <http.MultipartFile>[];
    for(var i = 0; i < pictures.length; i++){
      var path = pictures[i].path;
      uploadList.add(
          await MultipartFile.fromPath(
            'image',
            path,
            filename: path.split('/').last
          )
      );
    }
    var res = await request.send();
    print(res.statusCode);

  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: ListView.builder(
            itemCount: images.length,
            itemBuilder: (context, index) {
              print(images[index].path);
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.file(File(images[index].path)),
              );
            }));
  }
  }

