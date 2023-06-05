
import 'package:car_accident_management/pages/single_image.dart';
import 'package:flutter/material.dart';

class DisplayImagesPage extends StatelessWidget {
  final List<dynamic>? images;
  const DisplayImagesPage({Key? key, required this.images}) : super(key: key);

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
          'Crash Images',
          style: TextStyle(color: Color(0xFF3AD425), fontSize: 15.0),
        ),
        centerTitle: true,
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
          return GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SingleImage(
                  imageLink: images?[index],
                )),
              );
            },
            child: Image.network(images?[index]),
          );
          }),
          ),
    );
  }
}
