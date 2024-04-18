import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';
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
