import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/custom_elevated.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/core/cache_helper.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/about/view.dart';
import 'package:hassadak/pages/login/view.dart';
import 'package:hassadak/pages/update_password/view.dart';

import 'components/build_container_shadow.dart';
import 'personal_data/view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SizedBox(
        width: 1.sw,
        height: 1.sh,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(
            children: [
              SizedBox(
                height: 0.02.sh,
              ),
              ContainerWithShadow(
                onTap: () {
                  navigateTo(page: const PersonalDataView());
                },
                image: "assets/icons/user.svg",
                title: "المعلومات الشخصية ",
                color: ColorManager.secMainColor,
              ),
              ContainerWithShadow(
                onTap: () {
                  navigateTo(page: const UpdatePasswordView());
                },
                image: "assets/icons/setting.svg",
                title: "الاعدادات",
                color: ColorManager.secMainColor,
              ),
              ContainerWithShadow(
                onTap: () {},
                image: "assets/icons/help.svg",
                title: "مركز المساعدة",
                color: ColorManager.secMainColor,
              ),
              ContainerWithShadow(
                onTap: () {
                  navigateTo(page: const AboutView());
                },
                image: "assets/icons/about.svg",
                title: "عن التطبيق",
                color: ColorManager.secMainColor,
              ),
              ContainerWithShadow(
                onTap: () {
                  showDialog(
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          title: CustomText(
                            text: "تسجيل الخروج",
                            color: ColorManager.mainColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.sp,
                          ),
                          content: CustomText(
                            text: "هل انت متأكد من تسجيل الخروج؟",
                            color: ColorManager.mainColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 18.sp,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: CustomText(
                                text: "الغاء",
                                fontSize: 18.sp,
                                color: ColorManager.navGrey,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            CustomElevated(
                              press: () {
                                navigateTo(
                                    page: const LoginView(),
                                    withHistory: false);
                                CacheHelper.removeToken();
                                CacheHelper.removeId();
                              },
                              text: "خروج",
                              wSize: 100.w,
                              hSize: 40.sp,
                              borderRadius: 5.r,
                              btnColor: ColorManager.mainColor,
                            )
                          ],
                        );
                      },
                      context: context);
                },
                image: "assets/icons/logout.svg",
                title: "تسجيل الخروج",
                color: ColorManager.red,
                arrow: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
