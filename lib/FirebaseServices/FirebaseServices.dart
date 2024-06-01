import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:larvae_classification/Extensions/Extension.dart';
import 'package:larvae_classification/Screens/WelcomeScreen.dart';
import 'package:larvae_classification/User/userModel.dart' as model;
import "package:cloud_firestore/cloud_firestore.dart";

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<model.UserDetail> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return model.UserDetail.fromSnap(snap);
  }

  Future<String> signInwithEmailAndpassword(
      BuildContext context, email, String password) async {
    String res = "Some error can be occur";
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res = "Success";
    } catch (e) {
      res = e.toString();
      return res;
    }
    return res;
  }

  Future<String> signUpwithEmailAndpassword(BuildContext context, String email,
      String password, String username) async {
    String res = "Some error can be occur";
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      model.UserDetail user = model.UserDetail(
          username: username,
          uid: credential.user!.uid,
          email: email,
          password: password);

      await _firestore
          .collection('users')
          .doc(credential.user!.uid)
          .set(user.ToJson());
          if(credential.user != null){
      res = "Success";
          }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> signOut(context) async {
    try {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Do you want to sign out?',
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
                  await _auth.signOut();
                  await _googleSignIn.signOut();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()));
                },
                icon: const Icon(Icons.check),
              ),
            ],
          );
        },
      );
    } catch (e) {
      (e.toString());
    }
  }

  String generateUsernameFromEmail(String email) {
    // Extract the username part before the '@' symbol
    String username = email.split('@').first;

    // Remove non-alphabetic characters from the username
    username = username.replaceAll(RegExp(r'[^a-zA-Z]'), '');

    // If the username is empty after removing non-alphabetic characters, use a default value
    if (username.isEmpty) {
      username = 'User';
    }

    // If the username starts with a number, add a prefix 'user'
    if (RegExp(r'^[0-9]').hasMatch(username)) {
      username = username;
    }

    return username.capitalize();
  }

  Future<String> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return "Sign-in cancelled by user";
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      String email = userCredential.user!.email ?? '';
      String photoURL = userCredential.user!.photoURL ?? '';

      // Generate username from email
      String username = generateUsernameFromEmail(email);

      model.UserDetail user = model.UserDetail(
        uid: userCredential.user!.uid,
        email: email,
        photoURL: photoURL,
        username: username, // Set the username here
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set(
            user.ToJson(),
          );

      return "Success";
    } catch (e) {
      return "Error signing in with Google: $e";
    }
  }
}
