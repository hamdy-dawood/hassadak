import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/custom_elevated.dart';
import 'package:hassadak/components/otp_form.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/new_password/view.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 0.05.sh,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgIcon(
                      icon: "assets/icons/logo.svg",
                      color: ColorManager.green,
                      height: 50.h,
                    ),
                    SizedBox(
                      width: 0.25.sw,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: SvgIcon(
                          icon: "assets/icons/back.svg",
                          color: ColorManager.black,
                          height: 18.h,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.05.sh,
                ),
                Align(
                  alignment: Alignment.center,
                  child: CustomText(
                    text: "التحقق من الرمز",
                    color: ColorManager.secMainColor,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 0.02.sh,
                ),
                CustomText(
                  text: "أرسل الرمز الذي ارسلناه الى $email",
                  color: ColorManager.grey,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 0.03.sh,
                  ),
                  child: const OtpForm(),
                ),
                CustomElevated(
                  text: "تأكيد",
                  press: () {
                    navigateTo(page: const NewPasswordView());
                  },
                  hSize: 50.h,
                  wSize: double.infinity,
                  btnColor: ColorManager.secMainColor,
                  borderRadius: 20.r,
                  fontSize: 18.sp,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
