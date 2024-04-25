import 'package:flutter/material.dart';
import 'package:larvae_classification/FirebaseServices/FirebaseServices.dart';
import 'package:larvae_classification/Screens/LoginScreen.dart';
import 'package:larvae_classification/Screens/MobileNavigationScreen.dart';
import 'package:larvae_classification/commonUtils/InputField.dart';
import 'package:larvae_classification/commonUtils/Snackbar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController userController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    FirebaseServices auth = FirebaseServices();

    @override
    void dispose() {
      super.dispose();
      emailController.dispose();
      userController.dispose();
      passwordController.dispose();
      confirmPasswordController.dispose();
    }

    void signUp(BuildContext context) async {
      if (formKey.currentState?.validate() ?? false) {
        setState(() {
          isLoading = true;
        });
        if (isLoading==true) {
         ShowSnackBar("circle", context);
        }
        String username = userController.text;
        String password = passwordController.text;
        String email = emailController.text;

        try {
          String res = await auth.signUpwithEmailAndpassword(
              context, email, password, username);
               setState(() {
            isLoading = false;
          });
          if (res == "Success") {
            ShowSnackBar(res, context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MobileNavigationScreen()));
          }
         
        } catch (e) {
          ShowSnackBar(e.toString(), context);
        }
      }
    }

    return Scaffold(
        body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
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
                    key: formKey,
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
                                controller: userController,
                                lbltxt: 'Full Name',
                                hnttxt: '',
                                icon: Icons.keyboard,
                                color: Colors.white,
                                kybrdtype: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter your full name';
                                  }
                                  if (!RegExp(r'^[a-zA-Z]+$')
                                      .hasMatch(value.trim())) {
                                    return 'Name should only contain alphabetic characters and must start with a character';
                                  }
                                  return null; // Validation passed
                                },
                              ),
                              InputField(
                                controller: emailController,
                                lbltxt: 'Email',
                                hnttxt: 'Enter Email',
                                icon: Icons.person,
                                color: Colors.white,
                                kybrdtype: TextInputType.text,
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
                                controller: passwordController,
                                lbltxt: 'Password',
                                hnttxt: 'Enter Password',
                                isPassword: true,
                                icon: Icons.visibility_off,
                                color: Colors.white,
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
                                controller: confirmPasswordController,
                                lbltxt: ' Confirm  Password',
                                hnttxt: 'Enter RePassword',
                                isPassword: true,
                                icon: Icons.visibility_off,
                                color: Colors.white,
                                kybrdtype: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter password';
                                  } else {
                                    if (value != passwordController.text) {
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
                                onTap: () => signUp(context),
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
                                  child: isLoading
                                      ? const Center(
                                          child: Text(
                                          'SIGN UP',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.white),
                                        )):const Center(
                                          child: CircularProgressIndicator(
                                              color: Colors.black))
                                      
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
                                        child: const Text('Log In',
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
