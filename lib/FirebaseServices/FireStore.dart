import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:larvae_classification/FirebaseServices/Storage.dart';
import 'package:larvae_classification/User/BlogsUser.dart';
import 'package:larvae_classification/commonUtils/Snackbar.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> delete(String postId, BuildContext context) async {
   
    try {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Do you want to delete?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () async {
                  Navigator.of(context).pop(); // Close the dialog
                },
                icon: const Icon(Icons.close),
              ),
              IconButton(
                onPressed: () async {
                  await _firestore
                      .collection("Blogs posts")
                      .doc(postId)
                      .delete();
                  ShowSnackBar("Success", context);
                  Navigator.of(context).pop(); // Close the dialog

                  // Close the dialog
                },
                icon: const Icon(Icons.check),
              ),
            ],
          );
        },
      );
    } catch (e) {
   ShowSnackBar(e.toString(), context);

    }
    
  }
  Future<bool> deletePrediction(String predictionId) async {
    try {
      // Get the document reference for the prediction using predictionId
      final predictionRef =
          _firestore.collection("Predictions").doc(predictionId);

      // Delete the document from Firestore
      await predictionRef.delete();
      return true;
    } catch (err) {
      if (kDebugMode) {
        print("Error deleting prediction: $err");
      }
      return false;

      // Handle error as needed
    }
  }
    Future<String> storePrediction(
      String label, double confidence, Uint8List picture) async {
    String res = "Some error can be occur";
    try {
      String photoUrl =
          await StorageMethod().blogImage("Predictions", picture, true);
      String predictionId = const Uuid().v1();

      // Additional data you may want to store
      DateTime predictionDate = DateTime.now();
      String userId = auth.currentUser!.uid; // Assuming user authentication

      // Create a model or map to store the prediction data
      Map<String, dynamic> predictionData = {
        'label': label,
        'confidence': confidence,
        'photoUrl': photoUrl,
        'predictionId': predictionId,
        'predictionDate': predictionDate,
        'userId': userId,
        // "prediction": prediction,
        // Add more fields as needed
      };

      await _firestore
          .collection("Predictions")
          .doc(predictionId)
          .set(predictionData);
      res = "Results Saveded successfully..";
    } catch (err) {
      if (kDebugMode) {
        print("Error storing prediction: $err");
      }
      // Handle error as needed
    }
    return res;
  }


  Future<String> uploadBlogs(
      String description, Uint8List file, String title) async {
    String res = "Some error can be occur";

    try {
      String photoUrl = await StorageMethod().blogImage("Blogs", file, true);
      String postId = const Uuid().v1();
      BlogsUser post = BlogsUser(
        description: description,
        title: title,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
      );
      await _firestore.collection("Blogs posts").doc(postId).set(post.ToJson());
      res = "Success";
    } catch (err) {
      res = err.toString();
      return res;
    }
    return res;
  }
}
