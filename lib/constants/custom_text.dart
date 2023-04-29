import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    Key? key,
    required this.text,
    required this.color,
    required this.fontWeight,
    required this.fontSize,
    this.textDecoration = TextDecoration.none,
    this.textAlign = TextAlign.start,
  }) : super(key: key);
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  final TextDecoration textDecoration;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.almarai(
        textStyle: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
        decoration: textDecoration,
      ),
    );
  }
}
