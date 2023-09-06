import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_sharing_app/view/screens/home_screen.dart';
import 'package:image_sharing_app/view/style/colors.dart';
import 'package:image_sharing_app/view/widgets/bottom_text_button.dart';
import 'package:image_sharing_app/view/widgets/button_widget.dart';
import 'package:image_sharing_app/view/widgets/flutter_toast.dart';
import 'package:image_sharing_app/view/widgets/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/design.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _signUp(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          ModalRoute.withName('/'));
      // print('Sign up successful');
    }
  }

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: yelloColor,
      ),
      body: SingleChildScrollView(
          child: Stack(
        children: [
          SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: PinkDesign(),
          ),
          Column(
            children: [
              SizedBox(
                height: screenHeight * .20,
              ),
              Text(
                'Register here',
                style: GoogleFonts.inter(
                    color: yelloColor,
                    fontWeight: FontWeight.w800,
                    fontSize: screenWidth * .08),
              ),
              Text(
                'Be a part of our vast community',
                style: GoogleFonts.inter(
                    color: const Color.fromARGB(139, 0, 0, 0),
                    fontWeight: FontWeight.w800,
                    fontSize: screenWidth * .04),
              ),
              SizedBox(
                height: screenHeight * .05,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFieldWidget(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email id';
                        }
                        // Regular expression pattern for validating email addresses
                        final emailRegex = RegExp(
                            r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      hintText: 'Email',
                      controller: _emailController,
                      icon: Icons.email,
                      trueOrFalse: false,
                    ),
                    SizedBox(
                      height: screenHeight * .03,
                    ),
                    TextFieldWidget(
                      hintText: 'Password',
                      controller: _passwordController,
                      icon: Icons.lock,
                      trueOrFalse: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: screenHeight * .03,
                    ),
                    TextFieldWidget(
                      hintText: 'Confirm Password',
                      controller: _confirmPasswordController,
                      icon: Icons.lock,
                      trueOrFalse: true,
                      validator: (value) {
                        // ignore: unrelated_type_equality_checks
                        if (_confirmPasswordController.text !=
                            _passwordController.text) {
                          return "Password doesn't match";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: screenHeight * .03,
                    ),
                    ButtonWidget(
                      press: () async {
                        if(_formKey.currentState!.validate()){
                          try {
                          await _auth.createUserWithEmailAndPassword(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          );
                          final User? user = _auth.currentUser;
                          final _uid = user!.uid;
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(_uid)
                              .set({
                            'id': _uid,
                            'email': _emailController.text,
                            'password': _passwordController.text,
                            'createAt': Timestamp.now()
                          });
                          // ignore: use_build_context_synchronously
                          _signUp(context);

                          //sharedPreference--------
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setBool('isAuthenticated', true);
                          //---------------------
                          
                        } catch (e) {
                          // ignore: use_build_context_synchronously
                          toastMessage(
                            'Please fill the columns',
                            context,
                            textFeildColor,
                          );
                        }
                        }
                      },
                      buttonText: 'Sign up',
                    ),
                    SizedBox(
                      height: screenHeight * .25,
                    ),
                    BottomTextButton(
                      linkText: 'Login here',
                      text: "Already Have an account",
                      navigation: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      )),
    );
  }
}
