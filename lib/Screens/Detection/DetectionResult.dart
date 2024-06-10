import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:larvae_classification/Screens/MobileNavigationScreen.dart';
import 'package:larvae_classification/Screens/ResultPage.dart';

// ignore: must_be_immutable
class DetectionResult extends StatefulWidget {
  List<dynamic>? results = [];
  final Uint8List? image;
  DetectionResult({this.results, this.image, super.key});

  @override
  State<DetectionResult> createState() => _DetectionResultState();
}

class _DetectionResultState extends State<DetectionResult> {
  bool isLoading = false;

  void _navigateToResultPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ResultPage(results: widget.results!, selectedimage: widget.image!),
      ),
    );
  }
 void _navigateToBack() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
         const   MobileNavigationScreen(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    
      return WillPopScope(
    onWillPop: () async {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MobileNavigationScreen()),
      );
      return false; // Returning false will prevent default back button behavior
    },
    child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xffB81736),
            Color(0xff281537),
          ]),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: widget.results!.isNotEmpty
                        ? const AssetImage('assets/images/checkDetected.png')
                        : const AssetImage('assets/images/NotDetected.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                ),
              ),
               const SizedBox(
                height: 50,
              ),
              Text(
                widget.results!.isNotEmpty? "Detected":"Not Detected"  ,
                style:  TextStyle(
                    fontSize: 30,
                          decoration: TextDecoration.none,
                    color:widget.results!.isNotEmpty? Colors.green:Colors.red,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 60,
              ),
              GestureDetector(
                onTap: () => widget.results!.isNotEmpty?_navigateToResultPage():_navigateToBack(),
                child: Container(
                  height: 65,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 112, 20, 38),
                      Color.fromARGB(255, 58, 57, 58),
                    ]),
                  ),
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.black))
                      :  Center(
                          child: Text(widget.results!.isNotEmpty?'Save':'Detect Next',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none,
                                  fontSize: 20,
                                  color: Colors.white)),
                        ),
                ),
              ),
            ],
          ),
        )));
  }
}
