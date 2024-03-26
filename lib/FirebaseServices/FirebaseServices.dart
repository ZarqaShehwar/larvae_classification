import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:larvae_classification/Provider/UserData.dart';
import 'package:provider/provider.dart';

class FirebaseServices {
final  FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String> signInwithEmailAndpassword(
      BuildContext context, email, String password) async {
    String res = "Some error can be occur";
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User? user = credential.user;

      // Update user information in UserProvider
      if (user != null) {
        Provider.of<UserData>(context, listen: false).updateUserInfo(
          uid: user.uid,
          displayName: '',
          email: user.email ?? '',
          photoURL: user.photoURL ?? '',
        );
      }
      res = "Success";
    } catch (e) {
      res = "${e.toString()}";
      return res;
    }
    return res;
  }

  Future<String> signUpwithEmailAndpassword(
      BuildContext context, String email, String password,String username) async {
    String res = "Some error can be occur";

    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        Provider.of<UserData>(context, listen: false).updateUserInfo(
          uid: credential.user!.uid,
          displayName: username ?? '',
          email: credential.user!.email ?? '',
          photoURL: credential.user!.photoURL ?? '',
        );
        res = "Success";
      }
    } catch (e) {
      res = "${e.toString()}";
      return res;
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
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => WelcomeScreen()));
                // },
                },
                icon: const Icon(Icons.check),
              ),
            ],
          );
        },
      );
    } catch (e){
      
    }
  }

  Future<String> signInWithGoogle(BuildContext context) async {
    String res = "Some error can be occur";
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return res ;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential User = await _auth.signInWithCredential(credential);
      Provider.of<UserData>(context, listen: false).updateUserInfo(
        uid: User.user!.uid,
        displayName:  '',
        email: User.user!.email ?? '',
        photoURL: User.user!.photoURL ?? '',
      );
      return res = "Success";
    } catch (e) {
      return res = "Error signing in with Google: $e";
    }
   
  }
}
