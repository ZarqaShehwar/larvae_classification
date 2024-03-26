import 'package:flutter/material.dart';
import 'package:larvae_classification/FirebaseServices/FirebaseServices.dart';
import 'package:larvae_classification/Screens/LoginScreen.dart';
import 'package:larvae_classification/commonUtils/InputField.dart';
import 'package:larvae_classification/commonUtils/Snackbar.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({Key? key}) : super(key: key);

  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController _userController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _confirmPasswordController = TextEditingController();
    FirebaseServices _auth = FirebaseServices();
    bool _isloading = true;
    @override
    void dispose() {
      _emailController.dispose();
      _userController.dispose();
      _passwordController.dispose();
      _confirmPasswordController.dispose();
    }

    void SignUp(BuildContext context) async {
      if (_formKey.currentState?.validate() ?? false) {
        String username = _userController.text;
        String password = _passwordController.text;
        String email = _emailController.text;

        try {
          setState(() {
            _isloading = true;
          });
          String res = await _auth.signUpwithEmailAndpassword(context,email, password,username);
          ShowSnackBar(res, context);
        } catch (e) {
          // Handle any errors during registration
          ShowSnackBar(e.toString(), context);
        }
      }
    }

    return Scaffold(
        body: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Stack(
              children: [
                Container(
                  height: 400,
                  width: MediaQuery.sizeOf(context).width,
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
                  child: Form(
                    key: _formKey,
                    child: Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)),
                          color: Colors.white,
                        ),
                        width: MediaQuery.sizeOf(context).width,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 18.0, right: 18, top: 20),
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
                                  if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                                    return 'Name should only contain alphabetic characters and must start with a character';
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
                                    bool isValidEmail = RegExp(
                                            r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
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
                                isPassword: true,
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
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              const SizedBox(
                                height: 40,
                              ),
                              InkWell(
                                onTap: () => SignUp(context),
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
                                  child: _isloading != false
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                              color: Colors.white))
                                      : const Center(
                                          child: Text(
                                          'SIGN UP',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.white),
                                        )),
                                ),
                              ),

                              Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Text(
                                      "Already have an Account?",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    ),
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
                                      child: TextButton(
                                        onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginScreen())),
                                        child: Text('Log In',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            )),
                                      ),
                                    ),
                                  ],
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
                ),
              ],
            )));
  }
}
