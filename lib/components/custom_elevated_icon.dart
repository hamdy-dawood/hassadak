import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';

class CustomElevatedWithIcon extends StatelessWidget {
  final String text, image;
  final Color textColor, btnColor;
  final double hSize, wSize, fontSize, borderRadius;
  final VoidCallback press;

  const CustomElevatedWithIcon({
    Key? key,
    required this.text,
    required this.image,
    required this.press,
    this.textColor = Colors.white,
    required this.btnColor,
    this.hSize = 50,
    this.wSize = 200,
    this.fontSize = 17,
    this.borderRadius = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: SvgPicture.asset(
          image,
          height: 20.h,
        ),
      ),
      onPressed: press,
      style: ElevatedButton.styleFrom(
        backgroundColor: btnColor,
        elevation: 0.0,
        fixedSize: Size(wSize, hSize),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: ColorManager.navGrey)),
      ),
      label: CustomText(
        text: text,
        color: textColor,
        fontWeight: FontWeight.normal,
        fontSize: fontSize,
      ),
    );
  }
}
