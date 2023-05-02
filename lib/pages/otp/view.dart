import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hassadak/components/back_with_logo.dart';
import 'package:hassadak/components/custom_elevated.dart';
import 'package:hassadak/components/custom_form_field.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/bottom_nav_bar/view.dart';
import 'package:hassadak/pages/otp/states.dart';
import 'package:pinput/pinput.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'cubit.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpCubit(),
      child: Builder(builder: (context) {
        final cubit = OtpCubit.get(context);
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
                      controller: cubit.otpController,
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
                        if ((otp != cubit.otpController.text)) {
                          return "من فضلك تحقق من الرمز";
                        }
                        return null;
                      },
                    ),
                  ),
                  BlocBuilder<OtpCubit, OtpStates>(
                    builder: (context, state) {
                      return CustomTextFormField(
                        controller: cubit.passwordController,
                        hint: 'كلمة المرور ',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(8.0.w),
                          child: SvgIcon(
                            icon: "assets/icons/lock.svg",
                            color: ColorManager.grey,
                            height: 10.h,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            cubit.passwordVisibility();
                          },
                          icon: Icon(
                            cubit.securePass
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                          color: ColorManager.navGrey,
                        ),
                        obscureText: cubit.securePass,
                        isLastInput: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'من فضلك ادخل كلمة المرور !';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 0.02.sh,
                  ),
                  BlocBuilder<OtpCubit, OtpStates>(
                    builder: (context, state) {
                      return CustomTextFormField(
                        controller: cubit.confirmPasswordController,
                        hint: 'تأكيد كلمة المرور',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(8.0.w),
                          child: SvgIcon(
                            icon: "assets/icons/lock.svg",
                            color: ColorManager.grey,
                            height: 10.h,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            cubit.confPasswordVisibility();
                          },
                          icon: Icon(
                            cubit.secureConfPass
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                          color: ColorManager.grey,
                        ),
                        obscureText: cubit.secureConfPass,
                        isLastInput: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'من فضلك ادخل نفس كلمة المرور !';
                          } else if (value != cubit.passwordController.text) {
                            return 'كلمة المرور ليست مطابقة !';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 0.03.sh,
                  ),
                  BlocConsumer<OtpCubit, OtpStates>(
                    listener: (context, state) {
                      if (state is OtpFailureState) {
                        showMessage(message: state.msg);
                      } else if (state is OtpSuccessState) {
                        navigateTo(page: NavBarView());
                        print(cubit.otpController.text);
                        print(cubit.passwordController);
                      }
                    },
                    builder: (context, state) {
                      if (state is OtpLoadingState) {
                        return JumpingDotsProgressIndicator(
                          fontSize: 50.h,
                          color: ColorManager.secMainColor,
                        );
                      }
                      return CustomElevated(
                        text: "تأكيد",
                        press: cubit.verifyOtp,
                        hSize: 50.h,
                        wSize: double.infinity,
                        btnColor: ColorManager.secMainColor,
                        borderRadius: 20.r,
                        fontSize: 18.sp,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
