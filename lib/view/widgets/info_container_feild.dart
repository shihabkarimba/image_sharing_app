import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_sharing_app/view/style/colors.dart';

class Containerfield extends StatelessWidget {
  final String text;
  final VoidCallback? function;
  final bool hasEdit;
  const Containerfield({
    super.key,
    required this.text,
    this.function,
    this.hasEdit = true,
  });

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Container(
        width: double.infinity,
        height: screenHeight * .07,
        decoration: BoxDecoration(
            color: textFeildColor, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              hasEdit
                  ? IconButton(
                      onPressed: function,
                      icon: const Icon(
                        Icons.edit,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
