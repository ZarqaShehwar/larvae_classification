// ignore_for_file: file_names, must_be_immutable, use_build_context_synchronously

import 'dart:convert' show LineSplitter;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:larvae_classification/FirebaseServices/FireStore.dart';
import 'package:larvae_classification/Screens/DengueDetailPage.dart';
import 'package:larvae_classification/Screens/MobileNavigationScreen.dart';
import 'package:larvae_classification/commonUtils/Snackbar.dart';

class ResultPage extends StatelessWidget {
  final List results;
  Uint8List selectedimage;
  final FirestoreMethods _firestore = FirestoreMethods();
  ResultPage({super.key, required this.results, required this.selectedimage}) {
    _loadLabels();
  }

  List<String> labels = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detection Results'),
      ),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DengueDetailPage(
                          scientificName: results[index]['tag'],
                          image: selectedimage)));
            },
            child: Card(
              child: ListTile(
                leading:
                    Image.memory(selectedimage), //Image.file(selectedimage),
                title: Text('${results[index]['tag']}'),
                subtitle: Text(
                    'Confidence: ${results[index]['box'][4].toStringAsFixed(2)}%'),
                trailing: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: double.parse(
                                results[index]['box'][4].toStringAsFixed(2)) >
                            0.5
                        ? Colors.green
                        : Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    results[index]['box'][4].toStringAsFixed(2),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                // Save results
                for (var result in results) {
                  String res = await _firestore.storePrediction(
                    result['tag'],
                    double.parse(result['box'][4].toStringAsFixed(2)),
                    selectedimage,
                    _getprediction(result),
                  );
                  ShowSnackBar(res, context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MobileNavigationScreen()));
                }
              },
              child: const Text('Save Results'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MobileNavigationScreen()));
              },
              child: const Text('Detect Next'),
            ),
          ],
        ),
      ),
    );
  }

  _loadLabels() async {
    String data = await rootBundle.loadString('assets/labels.txt');
    labels = const LineSplitter().convert(data);
  }

  _getprediction(result) {
    if (labels.contains(result['tag'])) {
      // Tag is in the list of labels
      return true;
    } else {
      // Tag is not in the list of labels
      return false;
    }
  }
}