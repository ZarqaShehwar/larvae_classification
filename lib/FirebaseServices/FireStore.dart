import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:typed_data';
import 'package:larvae_classification/FirebaseServices/Storage.dart';
import 'package:larvae_classification/User/BlogsUser.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> uploadBlogs(
      String description, Uint8List file, String title) async {
    String res = "Some error can be occur";

    try {
      String photoUrl = await StorageMethod().BlogImage("Blogs", file, true);
      String postId = const Uuid().v1();
      BlogsUser post = BlogsUser(
        description: description,
        title: title,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
      );
      await _firestore.collection("Blogs posts").doc(auth.currentUser!.uid).set(post.ToJSON());
      res = "Success";
    } catch (err) {
      res = "${err.toString()}";
      return res;
    }
    return res;
  }
}
