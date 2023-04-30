import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/constants/color_manager.dart';

import 'svg_icons.dart';

class BackWithLogo extends StatelessWidget {
  const BackWithLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: 10.h,bottom: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgIcon(
            icon: "assets/icons/logo.svg",
            color: ColorManager.green,
            height: 50.h,
          ),
          SizedBox(
            width: 0.25.sw,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: SvgIcon(
                icon: "assets/icons/back.svg",
                color: ColorManager.black,
                height: 18.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
