import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  final bool trueOrFalse;
  final String? Function(String?)? validator;

  const TextFieldWidget({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.icon,
    required this.trueOrFalse,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: TextFormField(
        validator: validator,
        obscureText: trueOrFalse,
        style: TextStyle(color: Colors.white),
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Color(0xFFFF4A7D),
          hintText: hintText,
          prefixIcon: Icon(icon, color: Color.fromARGB(189, 255, 255, 255)),
          hintStyle: TextStyle(
            color: Color.fromARGB(189, 255, 255, 255),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
        ),
      ),
    );
  }
}
