import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:larvae_classification/FirebaseServices/FirebaseServices.dart';
import 'package:larvae_classification/Screens/HomeScreen.dart';
import 'package:larvae_classification/commonUtils/Snackbar.dart';
import 'SignUpScreen.dart';
import 'LoginScreen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key);
  final FirebaseServices _auth = FirebaseServices();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    void signInwithgoogle(BuildContext context) async {
      try {
        String res = await _auth.signInWithGoogle(context);
        if (res == "Success") {
          // ignore: use_build_context_synchronously
          ShowSnackBar(res, context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }
      } catch (e) {
        ShowSnackBar("${e.toString()}", context);
      }
    }

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xffB81736),
          Color(0xff281537),
        ])),
        child: Column(children: [
          // const Padding(
          //   padding: EdgeInsets.only(top: 200.0),
          //   child: Image(image: AssetImage('assets/images/img_inner_page.png')),
          // ),
          const SizedBox(
            height: 200,
          ),
          const Text(
            'Welcome Back',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: Container(
              height: 53,
              width: 320,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white),
              ),
              child: const Center(
                child: Text(
                  'SIGN IN',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegScreen()));
            },
            child: Container(
              height: 53,
              width: 320,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white),
              ),
              child: const Center(
                child: Text(
                  'SIGN UP',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Login with Social Media',
            style: TextStyle(fontSize: 17, color: Colors.white),
          ), //
          const SizedBox(
            height: 18,
          ),

          InkWell(
            onTap: () => {signInwithgoogle(context)},
            child: Container(
                height: 53,
                width: 320,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('assets/images/google.png')),
                    SizedBox(width: 10),
                    Text(
                      "Continue with Google",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    )
                  ],
                )),
          ),
        ]),
      ),
    );
  }
}
