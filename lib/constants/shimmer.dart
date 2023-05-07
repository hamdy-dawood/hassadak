import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:shimmer/shimmer.dart';

class ContainerShimmer extends StatelessWidget {
  const ContainerShimmer({
    Key? key,
    required this.height,
    required this.width,
    required this.margin,
    required this.padding,
    this.radius = 12,
  }) : super(key: key);

  final double height, width, radius;
  final EdgeInsets margin, padding;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorManager.shimmerBaseColor,
      highlightColor: ColorManager.shimmerHighlightColor,
      direction: ShimmerDirection.rtl,
      child: Container(
        margin: margin,
        padding: padding,
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius.r),
          color: Colors.grey.withOpacity(0.9),
        ),
      ),
    );
  }
}

class ListTileShimmer extends StatelessWidget {
  const ListTileShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ListTile(
        leading: ShimmerWidget.circular(
          height: 45.h,
          width: 45.h,
          shapeBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.r),
          ),
        ),
        title: ShimmerWidget.rectangular(height: 12.h),
        trailing: Icon(
          Icons.favorite,
          size: 30.sp,
          color: ColorManager.shimmerBaseColor,
        ),
      ),
    );
  }
}

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular(
      {super.key, this.width = double.infinity, required this.height})
      : shapeBorder = const RoundedRectangleBorder();

  const ShimmerWidget.circular(
      {super.key,
      this.width = double.infinity,
      required this.height,
      this.shapeBorder = const CircleBorder()});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorManager.shimmerBaseColor,
      highlightColor: ColorManager.shimmerHighlightColor,
      direction: ShimmerDirection.rtl,
      child: Container(
        height: height,
        width: width,
        decoration: ShapeDecoration(
          color: Colors.grey.shade300,
          shape: shapeBorder,
        ),
      ),
    );
  }
}
