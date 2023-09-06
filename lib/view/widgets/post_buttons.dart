import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonForPosts extends StatelessWidget {
  final Color? color;
  final String text;
  final VoidCallback? onTap;
  const ButtonForPosts({
    super.key,
    this.color,
    this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 50,
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
