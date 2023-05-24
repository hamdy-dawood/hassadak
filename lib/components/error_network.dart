import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'custom_elevated.dart';

class ErrorNetwork extends StatelessWidget {
  const ErrorNetwork({Key? key, required this.press, this.reloadButton = true})
      : super(key: key);
  final VoidCallback press;
  final bool reloadButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 0.15.sh,
          child: CachedNetworkImage(
            imageUrl: UrlsStrings.networkErrorUrl,
            placeholder: (context, url) => JumpingDotsProgressIndicator(
              fontSize: 50.h,
              color: ColorManager.secMainColor,
            ),
            errorWidget: (context, url, error) => Center(
              child: Image.asset(
                "assets/images/no_network.png",
              ),
            ),
          ),
        ),
        CustomText(
          text: "يرجي التحقق من الانترنت",
          color: ColorManager.mainColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.normal,
        ),
        SizedBox(height: 20.h),
        reloadButton
            ? CustomElevated(
                text: "إعادة التحميل",
                press: press,
                hSize: 40.h,
                wSize: 180.w,
                btnColor: ColorManager.secMainColor,
                borderRadius: 12.r,
                fontSize: 15.sp,
              )
            : const SizedBox(),
      ],
    );
  }
}
