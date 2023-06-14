import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:progress_indicators/progress_indicators.dart';

class BuildCacheCircleImage extends StatelessWidget {
  const BuildCacheCircleImage(
      {Key? key,
      required this.height,
      required this.loadingHeight,
      required this.imageUrl})
      : super(key: key);

  final double height, loadingHeight;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: height.h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: ColorManager.secMainColor,
        shape: BoxShape.circle,
      ),
      child: CachedNetworkImage(
        fit: BoxFit.contain,
        imageUrl: imageUrl,
        placeholder: (context, url) => JumpingDotsProgressIndicator(
          fontSize: loadingHeight.h,
          color: ColorManager.white,
        ),
        errorWidget: (context, url, error) => Center(
          child: Image.asset("assets/images/no_image.png"),
        ),
      ),
    );
  }
}
