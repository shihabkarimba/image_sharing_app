import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_sharing_app/view/style/colors.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback press;
  const ButtonWidget({super.key, required this.buttonText,required this.press});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Container(
          width: double.infinity,
          height: screenHeight * .055,
          decoration: BoxDecoration(
            color: yelloColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
              child: Text(
            buttonText,
            style: GoogleFonts.inter(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
          )),
        ),
      ),
    );
  }
}
