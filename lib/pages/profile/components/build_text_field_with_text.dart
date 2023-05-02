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

  }) : super(key: key);
  final String title, hint;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: title,
            color: ColorManager.grey,
            fontWeight: FontWeight.normal,
            fontSize: 20.sp,
          ),
          SizedBox(
            height: 5.h,
          ),
          TextFormField(
            readOnly: true,
            keyboardType: TextInputType.text,
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
            ),
          ),
        ],
      ),
    );
  }
}
