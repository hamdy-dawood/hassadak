import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';

import '../../../components/svg_icons.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {Key? key, required this.image, required this.name, required this.onTap})
      : super(key: key);
  final String image, name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          radius: 20.r,
          backgroundImage: AssetImage(image),
        ),
        title: CustomText(
          text: name,
          color: ColorManager.mainColor,
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // CustomText(
            //   text: "${349}+",
            //   color: ColorManager.green,
            //   fontWeight: FontWeight.normal,
            //   fontSize: 18.sp,
            // ),
            SizedBox(
              width: 10.w,
            ),
            SvgIcon(
              icon: 'assets/icons/fill_heart.svg',
              color: ColorManager.green,
              height: 18.h,
            ),
          ],
        ),
      ),
    );
  }
}
