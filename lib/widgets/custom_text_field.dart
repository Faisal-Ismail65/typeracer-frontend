import 'package:flutter/material.dart';
import 'package:typeracer/constants/styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key, required this.controller, required this.hint});
  final TextEditingController controller;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        fillColor: const Color(0xffF5F5FA),
        hintText: hint,
        hintStyle: AppStyle.textfieldHintStyle,
      ),
    );
  }
}
