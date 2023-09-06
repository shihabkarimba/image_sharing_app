import 'package:flutter/material.dart';
import 'package:image_sharing_app/view/screens/home_screen.dart';
import 'package:image_sharing_app/view/screens/launching_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  void _checkAuthentication() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isAuthenticated = prefs.getBool('isAuthenticated') ?? false;

    // Delay navigation by 3 seconds (3000 milliseconds)
    await Future.delayed(const Duration(milliseconds: 3000));

    // Navigate to the appropriate screen based on authentication
    if (isAuthenticated) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LaunchingScreen(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/image/advertising.png', // Path to your splash screen image
          width: 200, // Customize the width as needed
          height: 200, // Customize the height as needed
        ),
      ),
    );
  }
}
