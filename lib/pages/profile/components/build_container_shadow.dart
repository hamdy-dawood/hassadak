import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';

class ContainerWithShadow extends StatelessWidget {
  const ContainerWithShadow({
    Key? key,
    required this.onTap,
    required this.title,
    required this.image,
    required this.color,
    this.arrow = true,
  }) : super(key: key);
  final VoidCallback onTap;
  final String title, image;
  final Color color;
  final bool arrow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50.h,
          width: 1.sw,
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: ColorManager.navGrey,
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 28.w,
                  child: SvgPicture.asset(
                    image,
                    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: SvgIcon(
                    icon: "assets/icons/line.svg",
                    height: 22.h,
                    color: ColorManager.secMainColor,
                  ),
                ),
                CustomText(
                  text: title,
                  color: color,
                  fontWeight: FontWeight.normal,
                  fontSize: 18.sp,
                ),
                const Spacer(),
                arrow
                    ? Icon(
                        Icons.arrow_back_ios_new,
                        color: color,
                        size: 18.sp,
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
