import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hassadak/constants/color_manager.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hint,
    this.onChanged,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.autoValidate = AutovalidateMode.onUserInteraction,
    this.isLastInput = false,
    this.controller,
    required this.validator,
    this.borderRadius = 20.0,
  });

  final Function(String)? onChanged;
  final String hint;
  final Widget? prefixIcon;
  final IconButton? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final AutovalidateMode autoValidate;
  final bool isLastInput;
  final TextEditingController? controller;
  final FormFieldValidator validator;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: autoValidate,
      keyboardType: keyboardType,
      obscureText: obscureText,
      textInputAction:
          isLastInput ? TextInputAction.done : TextInputAction.next,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.almarai(
          textStyle: TextStyle(
            color: ColorManager.grey,
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: ColorManager.lightGrey,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.grey,
            ),
            borderRadius: BorderRadius.circular(borderRadius)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.mainColor,
            ),
            borderRadius: BorderRadius.circular(borderRadius)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.red,
            ),
            borderRadius: BorderRadius.circular(borderRadius)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.red,
            ),
            borderRadius: BorderRadius.circular(borderRadius)),
      ),
    );
  }
}
