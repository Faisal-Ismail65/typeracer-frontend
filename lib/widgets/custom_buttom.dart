import 'package:flutter/material.dart';
import 'package:typeracer/constants/styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.isHome = false});
  final String text;
  final void Function()? onTap;
  final bool isHome;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(isHome ? width / 5 : width, 50),
      ),
      child: Text(
        text,
        style: AppStyle.customButtonStyle,
      ),
    );
  }
}
