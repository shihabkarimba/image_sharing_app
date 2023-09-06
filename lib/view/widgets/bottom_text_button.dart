import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_sharing_app/view/style/colors.dart';

class BottomTextButton extends StatelessWidget {
  final String text;
  final String linkText;
  final VoidCallback navigation;
  const BottomTextButton({
    super.key,
    required this.linkText,
    required this.text,
    required this.navigation
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: GoogleFonts.inter(
            color: const Color.fromARGB(115, 0, 0, 0),
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: navigation,
          child: Text(
            linkText,
            style: GoogleFonts.inter(
              color: yelloColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}


