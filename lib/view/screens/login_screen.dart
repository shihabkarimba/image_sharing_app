import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_sharing_app/view/screens/forgot_password_screen.dart';
import 'package:image_sharing_app/view/screens/home_screen.dart';
import 'package:image_sharing_app/view/screens/sign_up_screen.dart';
import 'package:image_sharing_app/view/widgets/bottom_text_button.dart';
import 'package:image_sharing_app/view/widgets/button_widget.dart';
import 'package:image_sharing_app/view/widgets/flutter_toast.dart';
import 'package:image_sharing_app/view/widgets/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/design.dart';
import '../style/colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: screenHeight,
              width: screenWidth,
              child: const PinkDesign(),
            ),
            Column(
              children: [
                SizedBox(
                  height: screenHeight * .25,
                ),
                Text(
                  'Welcome back',
                  style: GoogleFonts.inter(
                    color: yelloColor,
                    fontWeight: FontWeight.w800,
                    fontSize: screenWidth * .08,
                  ),
                ),
                Text(
                  'We are glad you are back',
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
                        hintText: 'Email',
                        controller: _emailController,
                        icon: Icons.email,
                        trueOrFalse: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email id';
                          }
                          final emailRegex = RegExp(
                              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
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
                          return null;
                        },
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 36,
                              // vertical: 10,
                            ),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPasswordScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Forgot Password',
                                style: GoogleFonts.inter(
                                  color: const Color.fromARGB(115, 0, 0, 0),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: screenHeight * .02,
                      ),
                      ButtonWidget(
                        press: () async {
                          if(_formKey.currentState!.validate()){
                            try {
                            await _auth.signInWithEmailAndPassword(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                            );

                            //sharedPreference authentication----------
                            
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setBool('isAuthenticated', true);

                            //----------------------------------

                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          } catch (error) {
                            // ignore: use_build_context_synchronously
                            toastMessage("Password does't match", context,
                                textFeildColor);
                          }
                          }
                        },
                        buttonText: 'Login',
                      ),
                      SizedBox(
                        height: screenHeight * .24,
                      ),
                      BottomTextButton(
                        linkText: 'Sign up here',
                        text: "Don't have an account",
                        navigation: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
