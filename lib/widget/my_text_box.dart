import 'package:flutter/material.dart';
import 'package:moon2/constant/app_colors.dart';
import 'package:moon2/constant/app_font.dart';
class MyTextBox extends StatelessWidget {
  final double fontSize;
  final bool isSecure;
  final String text;
  final TextEditingController? controller;
  final double verticalPadding;
  final double horizontalPadding;
  const MyTextBox({super.key,this.verticalPadding = 20,this.horizontalPadding = 10,this.fontSize = 20,this.isSecure = false,this.text = "", this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.gray,
      ),
      child: TextField(
        controller: controller,
        style: appFont(fontSize: fontSize),
        cursorColor: Colors.black,
        obscureText: isSecure,
        cursorErrorColor: Colors.black,
        decoration: InputDecoration(
          hintText: text,
          contentPadding:  EdgeInsets.symmetric(vertical: verticalPadding,horizontal: horizontalPadding),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusColor: Colors.black,
          fillColor: Colors.black,
          hoverColor: Colors.black,
        ),

      ),
    );
  }
}
