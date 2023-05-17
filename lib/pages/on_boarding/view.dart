import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/custom_elevated.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/core/cache_helper.dart';
import 'package:hassadak/pages/login/view.dart';

import '../../core/snack_and_navigate.dart';
import 'model.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final controller = OnBoardingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: Stack(
          children: [
            SizedBox(
              height: 0.55.sh,
              width: 1.sw,
              child: Image.asset(
                controller.model[controller.currentPage].image,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 10.h,
              right: 0,
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: CustomElevated(
                  text: 'تخطي',
                  press: () {
                    navigateTo(
                      page: const LoginView(),
                      withHistory: false,
                    );
                    CacheHelper.saveIfNotFirstTime();
                  },
                  hSize: 20.h,
                  wSize: 90.w,
                  fontSize: 15.sp,
                  textColor: ColorManager.white,
                  btnColor: ColorManager.mainColor,
                  borderRadius: 15.r,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 0.55.sh,
                width: 1.sw,
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.r),
                      topLeft: Radius.circular(30.r)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgIcon(
                        icon: "assets/icons/logo.svg",
                        color: ColorManager.green,
                        height: 60.h,
                      ),
                      SizedBox(
                        height: 0.03.sh,
                      ),
                      CustomText(
                        text: controller.model[controller.currentPage].title,
                        color: ColorManager.mainColor,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      CustomText(
                        text: controller.model[controller.currentPage].subTitle,
                        color: ColorManager.navGrey,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.center,
                        maxLines: 5,
                      ),
                      SizedBox(
                        height: 0.04.sh,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            controller.model.length,
                            (index) => Padding(
                              padding: EdgeInsetsDirectional.only(end: 5.r),
                              child: Container(
                                height: 5.h,
                                width: index == controller.currentPage
                                    ? 35.w
                                    : 15.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: index == controller.currentPage
                                      ? ColorManager.green
                                      : ColorManager.navGrey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0.03.sh,
                      ),
                      SizedBox(
                        width: 80.w,
                        height: 80.w,
                        child: Stack(
                          children: [
                            SizedBox(
                              width: 80.w,
                              height: 80.w,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                  ColorManager.green,
                                ),
                                value: (controller.currentPage + 1) /
                                    (controller.model.length),
                              ),
                            ),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  if (controller.currentPage ==
                                      controller.model.length - 1) {
                                    CacheHelper.saveIfNotFirstTime();
                                    navigateTo(
                                      page: const LoginView(),
                                      withHistory: false,
                                    );
                                  } else {
                                    controller.currentPage++;
                                    setState(() {});
                                  }
                                },
                                child: Container(
                                  width: 60.w,
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                    color: ColorManager.green,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                    size: 25.sp,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
