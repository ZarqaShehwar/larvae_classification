import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:larvae_classification/Screens/HomeScreen.dart';
import 'package:larvae_classification/Screens/SignupScreen.dart';
import 'package:larvae_classification/commonUtils/Buton.dart';
import 'package:larvae_classification/commonUtils/InputField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:larvae_classification/FirebaseServices/FirebaseServices.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FirebaseServices _auth = FirebaseServices();

  void login() async {
    if (_formKey.currentState?.validate() ?? false) {
      String email = _emailController.text;
      String password = _passwordController.text;

      try {
        User? user = await _auth.signInwithEmailAndpassword(email, password);
        if (user != null) {
          Fluttertoast.showToast(
            msg: "Login successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        } else {
          // Registration failed
          Fluttertoast.showToast(
            msg: "Login failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } catch (e) {
        print("Error during registration: $e");
        Fluttertoast.showToast(
          msg: "Error during Login: $e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }}

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xffB81736),
                Color(0xff281537),
              ]),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                'Hello\nSign in!',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Form(
              key: _formKey,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.white,
                ),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InputField(
                        controller: _emailController,
                        lbltxt: 'Email',
                        hnttxt: 'Enter Email',
                        icon: Icons.person,
                        kybrdtype: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Email';
                          } else {
                            bool isValidEmail =
                                RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                                    .hasMatch(value);

                            if (!isValidEmail) {
                              return 'Please enter a valid Email';
                            }
                          }
                          return null; // Validation passed
                        },
                      ),
                      InputField(
                        controller: _passwordController,
                        lbltxt: 'Password',
                        hnttxt: 'Enter Password',
                        isPassword: true,
                        icon: Icons.visibility_off,
                        kybrdtype: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          } 
                          return null; // Validation passed
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Color(0xff281537),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      InkWell(
                        onTap: () => login(),
                        child: Container(
                          height: 55,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(colors: [
                              Color(0xffB81736),
                              Color(0xff281537),
                            ]),
                          ),
                          child: const  Center(
                            child: Text(
                              'SIGN IN',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white
                               )
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                          
                          const Text("Don't have an Account?",style: TextStyle(fontSize: 12,color: Colors.grey),),
                          ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: <Color>[
                        Colors.black,
                        Colors.red,
                      ],
                    ).createShader(bounds);
                  },
                  child:
                           TextButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegScreen())), child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                               )
                            ), ),),
                        ],),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ));
    }
  }

