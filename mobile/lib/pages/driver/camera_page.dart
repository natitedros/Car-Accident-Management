import 'package:camera/camera.dart';
import 'package:car_accident_management/pages/driver/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key, required this.cameras, required this.caseId}) : super(key: key);

  final List<CameraDescription>? cameras;
  final String caseId;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  bool _isRearCameraSelected = true;
  List<XFile> pictures = [];
  int guideIndex = 0;
  List<String> guides = [
    "Capture the left side of your car",
    "Now the Front",
    "Now the right",
    "Now the back",
    "Top view of impact",
    "Side view of impact place",
    "All Done!"
  ];

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initCamera(widget.cameras![0]);
  }

  Future takePicture() async {
    if (!_cameraController.value.isInitialized) {
      return null;
    }
    if (_cameraController.value.isTakingPicture) {
      return null;
    }
    try {
      await _cameraController.setFlashMode(FlashMode.off);
      XFile picture = await _cameraController.takePicture();
      pictures.add(picture);
      setState(() {
        guideIndex = (guideIndex + 1) % guides.length;
      });
    } on CameraException catch (e) {
      debugPrint('Error occurred while taking picture: $e');
      return null;
    }
  }

  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController = CameraController(cameraDescription, ResolutionPreset.high);
    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      body: SafeArea(
        child: Stack(
          children: [
            (_cameraController.value.isInitialized)
                ? Center(child: CameraPreview(_cameraController))
                : Container(
              color: Colors.black,
              child: const Center(child: CircularProgressIndicator()),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.20,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
                  color: Colors.black,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        guides[guideIndex],
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          padding: const EdgeInsets.all(8.0),
                          iconSize: 30,
                          icon: Icon(
                            _isRearCameraSelected ? CupertinoIcons.switch_camera : CupertinoIcons.switch_camera_solid,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() => _isRearCameraSelected = !_isRearCameraSelected);
                            initCamera(widget.cameras![_isRearCameraSelected ? 0 : 1]);
                          },
                        ),
                        SizedBox(
                          width: width * 0.5,
                          height: height * 0.13,
                          child: ElevatedButton(
                            onPressed: takePicture,
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              primary: Colors.white, // Set button color to white
                            ),
                            child: Icon(
                              Icons.circle,
                              color: Colors.black, // Set icon color to black
                              size: 50,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            print(pictures[0].mimeType);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UploadImagePage(images: pictures, caseId: widget.caseId),
                              ),
                            );
                          },
                          iconSize: 40,
                          icon: const Icon(CupertinoIcons.check_mark_circled, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
