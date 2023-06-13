import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';

class TextFieldWithText extends StatelessWidget {
  const TextFieldWithText({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.titleColor = Colors.black,
    this.validator,
    this.autoValidate = AutovalidateMode.onUserInteraction,
    this.isLastInput = false,
    this.readOnly = false,
  }) : super(key: key);
  final String title, hint;
  final Color titleColor;
  final TextEditingController? controller;
  final FormFieldValidator? validator;
  final AutovalidateMode autoValidate;
  final bool isLastInput, readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: title,
            color: titleColor,
            fontWeight: FontWeight.normal,
            fontSize: 18.sp,
          ),
          SizedBox(
            height: 5.h,
          ),
          TextFormField(
            readOnly: readOnly,
            controller: controller,
            validator: validator,
            autovalidateMode: autoValidate,
            textInputAction:
                isLastInput ? TextInputAction.done : TextInputAction.next,
            keyboardType: TextInputType.text,
            style: GoogleFonts.almarai(
              textStyle: TextStyle(
                color: ColorManager.black,
                fontSize: 18.sp,
              ),
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.almarai(
                textStyle: TextStyle(
                  color: ColorManager.grey,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              filled: true,
              fillColor: ColorManager.lightGrey,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorManager.grey,
                ),
                borderRadius: BorderRadius.circular(20.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorManager.grey,
                ),
                borderRadius: BorderRadius.circular(20.r),
              ),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorManager.red,
                  ),
                  borderRadius: BorderRadius.circular(20.r)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorManager.red,
                  ),
                  borderRadius: BorderRadius.circular(20.r)),
            ),
          ),
        ],
      ),
    );
  }
}
