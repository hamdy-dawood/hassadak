import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon({
    Key? key,
    required this.icon,
    this.color = Colors.white12,
    this.height = 0,
  }) : super(key: key);

  final String icon;
  final Color color;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      height: height,
    );
  }
}
