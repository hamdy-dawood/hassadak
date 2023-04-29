import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  final double height, width,radius;
  final EdgeInsets margin, padding;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.25),
      highlightColor: Colors.white.withOpacity(0.6),
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
