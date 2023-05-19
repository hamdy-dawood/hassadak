import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';

class BottomBarItem extends StatelessWidget {
  final String icon, label;
  final VoidCallback onPress;
  bool isSelected = true;

  BottomBarItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPress,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onPress,
        child: Column(
          children: [
            Expanded(
              child: SvgPicture.asset(
                icon,
                height: 20.h,
                width: 20.h,
                colorFilter: ColorFilter.mode(
                  isSelected ? ColorManager.mainColor : ColorManager.navGrey,
                  BlendMode.srcIn,
                ),
              ),
            ),
            CustomText(
              text: label,
              color: isSelected ? ColorManager.mainColor : ColorManager.navGrey,
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}
