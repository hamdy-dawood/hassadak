import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/search/view.dart';

import 'svg_icons.dart';

AppBar backWithSearch(BuildContext context) {
  return AppBar(
    backgroundColor: ColorManager.white,
    elevation: 0.2,
    actions: [
      IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios_new,
          size: 22.sp,
          color: ColorManager.black,
        ),
      ),
    ],
    leading: InkWell(
      onTap: () {
        navigateTo(page: const SearchView());
      },
      child: Padding(
        padding: EdgeInsets.all(13.w),
        child: SvgIcon(
          icon: "assets/icons/search.svg",
          height: 20.h,
          color: ColorManager.black,
        ),
      ),
    ),
  );
}
