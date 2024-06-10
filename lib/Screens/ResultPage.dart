import 'dart:convert' show LineSplitter, Uint8List;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:larvae_classification/FirebaseServices/FireStore.dart';
import 'package:larvae_classification/Screens/DengueDetailPage.dart';
import 'package:larvae_classification/Screens/HomeScreen.dart';
import 'package:larvae_classification/Screens/MobileNavigationScreen.dart';
import 'package:larvae_classification/commonUtils/Snackbar.dart';

class ResultPage extends StatefulWidget {
  final List results;
  final Uint8List selectedimage;
  ResultPage({super.key, required this.results, required this.selectedimage});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
   final FirestoreMethods _firestore = FirestoreMethods();
  List<String> labels = [];

  @override
  void initState() {
    super.initState();
    _loadLabels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detection Results'),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MobileNavigationScreen()),
            );
          },
          icon: const Icon(
            FontAwesomeIcons.arrowLeft,
            size: 24,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.results.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
                leading: Image.memory(widget.selectedimage),
                title: Text('${widget.results[index]['tag']}'),
                subtitle: Text(
                  'Confidence: ${widget.results[index]['box'][4].toStringAsFixed(2)}%',
                ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: double.parse(widget.results[index]['box'][4].toStringAsFixed(2)) > 0.5
                        ? Colors.green
                        : Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.results[index]['box'][4].toStringAsFixed(2),
                    style: const TextStyle(color: Colors.white),
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
                for (var result in widget.results) {
                  var res = await _getprediction(result['tag']);
                  print('res$res');
                }

                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const Dialog(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(width: 20),
                            Text("Saving Results..."),
                          ],
                        ),
                      ),
                    );
                  },
                );

                late String res;
                // Save results
                for (var result in widget.results) {
                  res = await _firestore.storePrediction(
                    result['tag'],
                    double.parse(result['box'][4].toStringAsFixed(2)),
                    widget.selectedimage,
                  );
                }
                Navigator.pop(context); // Close the progress dialog
                ShowSnackBar(res, context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MobileNavigationScreen()),
                );
              },
              child: const Text('Save Results'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
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
    setState(() {
      labels = const LineSplitter().convert(data);
    });
  }

  _getprediction(String tag) {
    if (labels.contains(tag)) {
      // Tag is in the list of labels
      return true;
    } else {
      // Tag is not in the list of labels
      return false;
    }
  }
}
