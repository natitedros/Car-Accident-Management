
import 'dart:io';

import 'package:flutter/material.dart';

class DisplayImagesPage extends StatelessWidget {
  final List<dynamic>? images;
  const DisplayImagesPage({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('Accident Images')
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
          itemCount: images?.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          crossAxisCount: 2,
          ),

          itemBuilder: (context, index) {
          return Image.network(images?[index]);
          }),
          ),
    );
  }
}
