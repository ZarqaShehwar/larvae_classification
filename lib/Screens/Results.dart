import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:larvae_classification/FirebaseServices/FireStore.dart';
import 'package:larvae_classification/Screens/DengueDetailPage.dart';
import 'package:larvae_classification/Screens/MobileNavigationScreen.dart';
import 'package:larvae_classification/commonUtils/Snackbar.dart';

class MySavedResultsPage extends StatefulWidget {
  const MySavedResultsPage({super.key});

  @override
  _MySavedResultsPageState createState() => _MySavedResultsPageState();
}

class _MySavedResultsPageState extends State<MySavedResultsPage>{



  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirestoreMethods _firestoremethod = FirestoreMethods();
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';
  DateTime? _selectedDate;
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<List<Map<String, dynamic>>> _getPredictions() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
        .collection("Predictions")
        .where('userId', isEqualTo: _auth.currentUser!.uid)
        .get();

    List<Map<String, dynamic>> predictions = querySnapshot.docs
        .map((doc) => {
              ...doc.data(),
              'id': doc.id,
            })
        .toList();

    // Apply client-side filtering
    if (_searchTerm.isNotEmpty) {
      String searchLowercase = _searchTerm.toLowerCase();
      predictions = predictions.where((prediction) {
        String label = prediction['label'].toString().toLowerCase();
        return label.contains(searchLowercase);
      }).toList();
    }

    if (_selectedDate != null) {
      predictions = predictions.where((prediction) {
        DateTime predictionDate =
            (prediction['predictionDate'] as Timestamp).toDate();
        return predictionDate.year == _selectedDate!.year &&
            predictionDate.month == _selectedDate!.month &&
            predictionDate.day == _selectedDate!.day;
      }).toList();
    }

    // Apply client-side sorting
    predictions.sort((a, b) {
      DateTime dateA = (a['predictionDate'] as Timestamp).toDate();
      DateTime dateB = (b['predictionDate'] as Timestamp).toDate();
      return dateB.compareTo(dateA); // Descending order
    });

    return predictions;
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now().toLocal(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now().toLocal(),
    ).then((selectedDate) {
      if (selectedDate != null) {
        setState(() {
          _selectedDate =
              DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
          if (kDebugMode) {
            print(_selectedDate);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MobileNavigationScreen()));
            },
            icon: const Icon(
              FontAwesomeIcons.arrowLeft,
              size: 24,
              color: Colors.black,
            )),
        title: const Text("Saved Results"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _getPredictions(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data!.isEmpty) {
                    return Center(
                      child: Image.asset(
                        'assets/images/nodata.png',
                      ), // Replace with your asset's path
                    );
                  } else {
                    return RefreshIndicator(
                      onRefresh: () async {
                        setState(() {
                          _selectedDate = null;
                          _searchTerm = '';
                          // Reset any other filters as needed
                        });
                      },
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var document = snapshot.data![index];
                          // Handle the absence of 'prediction' field gracefully
                          bool isSafe = document['prediction'] == 'Safe';
                          return Card(
                            margin: const EdgeInsets.all(8.0),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ListTile(
                              hoverColor: Colors.blue[50],
                              leading: Image.network(
                                document['photoUrl'],
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error);
                                },
                              ),
                              title: Text(
                                document['label'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Confidence: ${document['confidence']}'),
                                  Text(
                                      'Date: ${(document['predictionDate'] as Timestamp).toDate().toLocal().toString().substring(0, 10)}'),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (document.containsKey('prediction'))
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 0),
                                      decoration: BoxDecoration(
                                        color:
                                            isSafe ? Colors.green : Colors.red,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        isSafe ? 'Safe' : 'Danger',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      _showDeleteDialog(context, document['id']);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String resultId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Delete Result'),
              content: const Text(
                  'Are you sure you want to delete this result?'),
              actions: <Widget>[
                if (!loading)
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                if (!loading)
                  TextButton(
                    child: const Text('Delete'),
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });

                      bool res =
                          await _firestoremethod.deletePrediction(resultId);
                      if (res) {
                        setState(() {
                          loading = false;
                        });
                        ShowSnackBar(
                            "Prediction deleted successfully!", context);
                        setState(() {
                          // Trigger a rebuild to refresh the data
                        });
                      } else {
                        setState(() {
                          loading = false;
                        });
                        ShowSnackBar("Failed to delete prediction.", context);
                      }

                      Navigator.of(context).pop();
                    },
                  ),
                if (loading)
                  const Center(
                      child: CircularProgressIndicator()), // Show loading indicator
              ],
            );
          },
        );
      },
    );
  }
}
