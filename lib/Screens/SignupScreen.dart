import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:larvae_classification/FirebaseServices/FirebaseServices.dart';
import 'package:larvae_classification/commonUtils/InputField.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegScreen extends StatelessWidget {
  const RegScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController _userController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _confirmPasswordController = TextEditingController();
    FirebaseServices _auth = FirebaseServices();

    @override
    void dispose() {
      _emailController.dispose();
      _userController.dispose();
      _passwordController.dispose();
      _confirmPasswordController.dispose();
    }

    void SignUp() async {
      if (_formKey.currentState?.validate() ?? false) {
        String username = _userController.text;
        String password = _passwordController.text;
        String email = _emailController.text;
        try {
          User? user = await _auth.signUpwithEmailAndpassword(email, password);
          if (user != null) {
            // Registration successful
            Fluttertoast.showToast(
              msg: "Registration successful",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          } else {
            // Registration failed
            Fluttertoast.showToast(
              msg: "Registration failed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        } catch (error) {
          // Handle any errors during registration
          print("Error during registration: $error");
          Fluttertoast.showToast(
            msg: "Error during registration: $error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      }
    }

    return Scaffold(
        body: SingleChildScrollView(
            child: Stack(
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
              'Create Your\nAccount',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child:Form(
            key:_formKey,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
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
                    controller: _userController,
                    lbltxt: 'Full Name',
                    hnttxt: '',
                    icon: Icons.keyboard,
                    kybrdtype: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null; // Validation passed
                    },
                  ),
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
                    icon: Icons.visibility_off,
                    kybrdtype: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      } else {
                        if (value.length < 8) {
                          return 'Password should be atleast of 8 character';
                        }
                      }
                      return null; // Validation passed
                    },
                  ),
                  InputField(
                    controller: _confirmPasswordController,
                    lbltxt: ' Confirm  Password',
                    hnttxt: 'Enter RePassword',
                    icon: Icons.visibility_off,
                    kybrdtype: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      } else {
                        if (value != _passwordController.text) {
                          return 'Confirm password does not match';
                        }
                      }
                      return null; // Validation passed
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  InkWell(
                    onTap: () {
                      SignUp();
                    },
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
                      child: const Center(
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          ),
        ),
        ),
      ],
    )));
  }
}
