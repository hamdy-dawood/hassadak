import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';

import 'svg_icons.dart';

AppBar backWithTitle(BuildContext context,
    {required String title, bool centerTitle = true}) {
  return AppBar(
    backgroundColor: ColorManager.white,
    elevation: 0.0,
    centerTitle: centerTitle,
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: SvgIcon(
        icon: "assets/icons/arrow.svg",
        height: 18.h,
        color: ColorManager.black,
      ),
    ),
    title: CustomText(
      text: title,
      color: ColorManager.mainColor,
      fontSize: 22.sp,
      fontWeight: FontWeight.bold,
    ),
  );
}
