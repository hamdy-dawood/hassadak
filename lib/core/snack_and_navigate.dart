import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hassadak/constants/color_manager.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void navigateTo({required Widget page, bool withHistory = true}) {
  Navigator.pushAndRemoveUntil(
      navigatorKey.currentContext!,
      PageRouteBuilder(
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            child,
        pageBuilder: (context, animation, secondaryAnimation) => page,
      ),
      (route) => withHistory);
}

showMessage({required String message, int maxLines = 1, double height = 50}) {
  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
    SnackBar(
      backgroundColor: ColorManager.mainColor,
      elevation: 2.0,
      content: SizedBox(
        height: height,
        child: Row(
          children: [
            Icon(
              Icons.error_outline_outlined,
              color: ColorManager.white,
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.almarai(
                  textStyle: TextStyle(
                    color: ColorManager.white,
                    fontSize: 16.sp,
                  ),
                ),
                maxLines: maxLines,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
