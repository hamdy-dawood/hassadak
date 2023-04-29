import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_manager.dart';
import 'custom_text.dart';

AppBar customAppBar({required String text}) {
  return AppBar(
    backgroundColor: ColorManager.white,
    elevation: 0.0,
    title: CustomText(
      text: text,
      color: ColorManager.mainColor,
      fontSize: 25.sp,
      fontWeight: FontWeight.bold,
    ),
    centerTitle: false,
  );
}
