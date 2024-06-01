// ignore_for_file: unnecessary_import, depend_on_referenced_packages, file_names, avoid_print

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:larvae_classification/Screens/Detection/DetectionResult.dart';

class PictureScreen extends StatefulWidget {
  final Uint8List? image;
  final File? selectedImage;
  const PictureScreen({super.key, this.image, this.selectedImage});

  @override
  State<PictureScreen> createState() => _PictureScreenState();
}

class _PictureScreenState extends State<PictureScreen> {
  late FlutterVision _vision;
  List<dynamic> _results = [];
  Future<void> loadModel() async {
    final res = await _vision.loadYoloModel(
        labels: 'assets/labels.txt',
        modelPath: 'assets/yolov8.tflite',
        modelVersion: "yolov8",
        quantization: false,
        numThreads: 1,
        useGpu: false);
    return res;
  }

 

  @override
  void initState() {
    super.initState();
    _vision = FlutterVision();
    final rs = loadModel().then((_) {
      print("Model loaded  successfully ");
    }).catchError((error) {
      print("Error loading model: $error");
    });
    if (kDebugMode) {
      print("ls$rs");
    }
  }
  Future<void> imageClassification(File image) async {
    Uint8List imageBytes = await image.readAsBytes();

    // Get image dimensions
    final decodedImage = await decodeImageFromList(imageBytes);
    int imageHeight = decodedImage.height;
    int imageWidth = decodedImage.width;

    print("Image Height: $imageHeight, Image Width: $imageWidth");

    var recognitions = await _vision.yoloOnImage(
      bytesList: imageBytes,
      imageHeight: imageHeight,
      imageWidth: imageWidth,
      iouThreshold: 0.8,
      confThreshold: 0.4,
      classThreshold: 0.4                                                                                                                         ,
    );

    print("Recognitions: $recognitions");

    setState(() {
      _results = recognitions;
    });
  }

  void _navigateToResultPage(List results, Uint8List image) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetectionResult(
          results: results,
          image: image,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height,
            width:MediaQuery.sizeOf(context).width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xffB81736),
                Color(0xff281537),
              ]),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  widget.image != null
                      ? Container(
                          width: 350,
                          height: 500,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(widget.image!),
                              fit: BoxFit.cover,
                            ),
                            // borderRadius:
                            //     const BorderRadius.all(Radius.circular(40)),
                          ),
                        )
                      : Container(
                          width: 350,
                          height: 500,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                        ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      // Show loading indicator
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      );
                      // Perform image classification
                      imageClassification(widget.selectedImage!)
                          .then((results) {
                        // Hide loading indicator
                        Navigator.pop(context); // Close loading dialog
                        // Navigate to ResultPage and pass the results
                        _navigateToResultPage(_results, widget.image!);
                        //                 Navigator.push(
                        // context,
                        // MaterialPageRoute(
                        //   builder: (context) =>
                        //    const   DetectionResult(),
                        // ),
                        // );
                      });
                    },
                    child: Container(
                      height: 55,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: Text(
                          'DETECT',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
