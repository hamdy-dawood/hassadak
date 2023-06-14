import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/build_cache_image.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';

import '../../../components/svg_icons.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {Key? key,
      required this.userImage,
      required this.name,
      required this.onTap,
      required this.tapLikeSeller,
      this.likes = 0})
      : super(key: key);
  final String userImage, name;
  final VoidCallback onTap, tapLikeSeller;
  final int likes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        height: 50.h,
        child: ListTile(
          onTap: onTap,
          leading: BuildCacheCircleImage(
            imageUrl: userImage,
            height: 45.h,
            loadingHeight: 20.h,
          ),
          title: CustomText(
            text: name,
            color: ColorManager.mainColor,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            maxLines: 1,
          ),
          trailing: InkWell(
            onTap: tapLikeSeller,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "$likes +",
                    color:
                        likes == 0 ? ColorManager.navGrey : ColorManager.green,
                    fontWeight: FontWeight.normal,
                    fontSize: 12.sp,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  SvgIcon(
                    icon: 'assets/icons/fill_heart.svg',
                    color:
                        likes == 0 ? ColorManager.navGrey : ColorManager.green,
                    height: 18.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
