import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleImage extends StatelessWidget {
  final String imageLink;
  const SingleImage({Key? key, required this.imageLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF3AD425)),
            onPressed: () => Navigator.of(context).pop(),
          ),backgroundColor: Colors.white,
        elevation: 3,
        title: const Text(
          'Single Image',
          style: TextStyle(color: Color(0xFF3AD425), fontSize: 15.0),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(child: Image.network(imageLink)),
      ),
    );
  }
}
