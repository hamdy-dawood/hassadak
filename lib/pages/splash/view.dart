import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/core/cache_helper.dart';
import 'package:hassadak/pages/bottom_nav_bar/view.dart';
import 'package:hassadak/pages/login/view.dart';
import 'package:hassadak/pages/on_boarding/view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool isFirstTime = CacheHelper.getIfFirstTime();
  String token = CacheHelper.getToken();

  @override
  void initState() {
    super.initState();
    _goNext();
  }

  _goNext() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    // navigateTo(page: const OnBoardingView(), withHistory: false);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => isFirstTime
            ? const OnBoardingView()
            : token.isEmpty
                ? const LoginView()
                : NavBarView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgIcon(
              icon: "assets/icons/logo.svg",
              color: ColorManager.green,
              height: 100.h,
            ),
          ],
        ),
      ),
    );
  }
}
