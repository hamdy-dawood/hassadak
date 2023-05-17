import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../../../components/svg_icons.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {Key? key,
      required this.image,
      required this.name,
      required this.onTap,
      this.likes = 0})
      : super(key: key);
  final String image, name;
  final VoidCallback onTap;
  final int likes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        height: 50.h,
        child: ListTile(
          onTap: onTap,
          leading: CircleAvatar(
            radius: 35.r,
            backgroundColor: ColorManager.secMainColor,
            child: ClipOval(
              child: CachedNetworkImage(
                fit: BoxFit.contain,
                imageUrl: image,
                placeholder: (context, url) => JumpingDotsProgressIndicator(
                  fontSize: 20.h,
                  color: ColorManager.secMainColor,
                ),
                errorWidget: (context, url, error) => Center(
                  child: Image.asset("assets/images/no_image.png"),
                ),
              ),
            ),
          ),
          title: CustomText(
            text: name,
            color: ColorManager.mainColor,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            maxLines: 1,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: "$likes +",
                color:likes == 0 ? ColorManager.navGrey : ColorManager.green,
                fontWeight: FontWeight.normal,
                fontSize: 12.sp,
              ),
              SizedBox(
                width: 5.w,
              ),
              SvgIcon(
                icon: 'assets/icons/fill_heart.svg',
                color: likes == 0 ? ColorManager.navGrey : ColorManager.green,
                height: 18.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
