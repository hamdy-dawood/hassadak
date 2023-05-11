import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:progress_indicators/progress_indicators.dart';

class ErrorNetwork extends StatelessWidget {
  const ErrorNetwork({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: UrlsStrings.networkErrorUrl,
          placeholder: (context, url) => JumpingDotsProgressIndicator(
            fontSize: 100.h,
            color: ColorManager.secMainColor,
          ),
          errorWidget: (context, url, error) => Center(
            child: Image.asset("assets/images/no_network.png"),
          ),
        ),
        CustomText(
          text: "يرجي التحقق من الانترنت",
          color: ColorManager.mainColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.normal,
        ),
      ],
    );
  }
}
