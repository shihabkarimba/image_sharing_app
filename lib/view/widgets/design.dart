import 'package:flutter/material.dart';
import 'package:image_sharing_app/view/style/colors.dart';

class PinkDesign extends StatefulWidget {
  const PinkDesign({super.key});

  @override
  _PinkDesignState createState() => _PinkDesignState();
}

class _PinkDesignState extends State<PinkDesign> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    // Create an AnimationController
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    // Add a listener to continuously update the containers
    controller.addListener(() {
      setState(() {});
    });

    // Start the animation
    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    // Dispose of the AnimationController when the widget is disposed
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Use the controller value for animations
    double container1Width = 0.8 + controller.value * 0.2;
    double container1Height = 0.4 + controller.value * 0.1;
    double container2Width = 0.7 + controller.value * 0.2;
    double container2Height = 0.35 + controller.value * 0.1;

    return Scaffold(
      body: Center(
        child: Stack(
          children: [

            //top design---------
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: screenWidth * container1Width,
                height: screenHeight * container1Height,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(400)),
                  color: pinkDark,
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: screenWidth * container2Width,
                height: screenHeight * container2Height,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(500)),
                  color: pinkDark,
                ),
              ),
            ),


            //Bottom desing--------
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: screenWidth * container1Width,
                height: screenHeight * container1Height,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(400)),
                  color: pinkDark,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: screenWidth * container2Width,
                height: screenHeight * container2Height,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(500)),
                  color: pinkDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}