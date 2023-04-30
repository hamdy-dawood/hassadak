import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hassadak/components/back_with_logo.dart';
import 'package:hassadak/components/custom_elevated.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/new_password/view.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key, required this.email});

  final String email;
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(
            children: [
              const BackWithLogo(),
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
                text: "أرسل الرمز الذي ارسلناه الى ",
                color: ColorManager.grey,
                fontSize: 18.sp,
                fontWeight: FontWeight.normal,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 0.01.sh,
              ),
              CustomText(
                text: email,
                color: ColorManager.grey,
                fontSize: 18.sp,
                fontWeight: FontWeight.normal,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.08.sh,
                ),
                child: Pinput(
                  length: 6,
                  controller: otpController,
                  defaultPinTheme: PinTheme(
                    height: 50.h,
                    width: 50.h,
                    textStyle: GoogleFonts.almarai(
                      textStyle: TextStyle(
                        color: ColorManager.black,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: ColorManager.navGrey),
                    ),
                  ),
                  errorPinTheme: PinTheme(
                    height: 50.h,
                    width: 50.h,
                    textStyle: GoogleFonts.almarai(
                      textStyle: TextStyle(
                        color: ColorManager.black,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: ColorManager.red),
                    ),
                  ),
                  validator: (otp) {
                    if ((otp != otpController.text)) {
                      return "من فضلك تحقق من الرمز";
                    }
                    return null;
                  },
                ),
              ),
              CustomElevated(
                text: "تأكيد",
                press: () {
                  print(otpController.text);
                  // navigateTo(page: const NewPasswordView());
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
    );
  }
}
