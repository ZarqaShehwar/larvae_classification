import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:larvae_classification/FirebaseServices/FirebaseServices.dart';
import 'package:larvae_classification/Screens/HomeScreen2.dart';
import 'SignUpScreen2.dart';
import 'LoginScreen.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

class WelcomeScreen extends StatelessWidget {
 WelcomeScreen({Key? key}) : super(key: key);
FirebaseServices _auth = FirebaseServices();
  @override
  Widget build(BuildContext context) {

    void SignInwithgoogle()async{
      try{
 UserCredential? user = await _auth.signInWithGoogle();
 if(user!=null){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen2()));
 }}
 catch(e){
  print('error occur while doing google ${e}');
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
                  MaterialPageRoute(builder: (context) => const RegScreen()));
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
         const SizedBox(height:20),
          const Text(
            'Login with Social Media',
            style: TextStyle(fontSize: 17, color: Colors.white),
          ), //
          const SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 80,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: ShaderMask(
                  blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) {
                      
                      return const LinearGradient(
                        colors: <Color>[
                          Colors.black,
                          Colors.red,
                        ],
                      ).createShader(bounds);
                    },
                    child: const  Icon(FontAwesomeIcons.facebookF,size: 24.0, )),
              ),
             const  SizedBox(width: 20,),
             InkWell(
              onTap: ()=>{
              SignInwithgoogle()
              },
             child:
              Container(
                height: 40,
                width: 80,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(30))

                ),
                child: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        colors: <Color>[
                          Colors.black,
                          Colors.red,
                        ],
                      ).createShader(bounds);
                    },
                    child:const  Icon(FontAwesomeIcons.google,size: 20.0,)),
              ),
             ),
            ],
          ),
       
        ]),
      ),
    );
  }
}
