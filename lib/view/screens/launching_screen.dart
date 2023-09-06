import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_sharing_app/view/screens/login_screen.dart';
import 'package:image_sharing_app/view/style/colors.dart';
import 'package:lottie/lottie.dart';

import '../widgets/design.dart';

class LaunchingScreen extends StatelessWidget {
  const LaunchingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          const PinkDesign(),
          Column(
            children: [
              SizedBox(height: 100,),
              SizedBox(
                width: 400,
                height: 300,
                child: Lottie.asset(
                  'assets/image/izp0dkDkba.json',
                  // width: ,
                  // height: 500,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 120,),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                child: Container(
                  width: screenWidth * .7,
                  height: screenHeight * .065,
                  decoration: BoxDecoration(
                    color: yelloColor,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Center(
                      child: Text(
                    "Let's get started",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: screenWidth * .055,
                    ),
                  )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
