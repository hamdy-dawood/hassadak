import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/search/view.dart';

import 'svg_icons.dart';

class TapToSearch extends StatelessWidget {
  const TapToSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                navigateTo(page: const SearchView());
              },
              child: Container(
                height: 45.h,
                decoration: BoxDecoration(
                  color: ColorManager.lightGrey,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 5.h, right: 5.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.w, horizontal: 8.w),
                          child: SvgIcon(
                            icon: "assets/icons/search.svg",
                            color: ColorManager.black,
                            height: 25.h,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        CustomText(
                          text: "بحث",
                          color: ColorManager.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 25.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 0.03.sw,
          ),
          InkWell(
            onTap: () {
              navigateTo(page: const SearchView());
            },
            child: Container(
              height: 45.h,
              width: 0.15.sw,
              decoration: BoxDecoration(
                color: ColorManager.lightGrey,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(12.h),
                child: SvgIcon(
                  icon: "assets/icons/rectangle.svg",
                  color: ColorManager.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
