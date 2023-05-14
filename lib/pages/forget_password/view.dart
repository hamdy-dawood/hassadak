import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/back_with_logo.dart';
import 'package:hassadak/components/custom_elevated.dart';
import 'package:hassadak/components/custom_form_field.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/constants/input_validator.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/otp/view.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'cubit.dart';
import 'states.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: Builder(
        builder: (context) {
          final cubit = ForgetPasswordCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: cubit.formKey,
                child: ListView(
                  children: [
                    const BackWithLogo(),
                    Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        text: "نسيت كلمة السر؟",
                        color: ColorManager.secMainColor,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    CustomText(
                      text:
                          "لا تقلق ، ما عليك سوى كتابة رقم هاتفك وسنرسل رمز التحقق.",
                      color: ColorManager.grey,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 0.05.sh,
                    ),
                    CustomTextFormField(
                      controller: cubit.emailController,
                      keyboardType: TextInputType.emailAddress,
                      hint: 'البريد الالكتروني',
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10.0.w),
                        child: SvgIcon(
                          icon: "assets/icons/email.svg",
                          color: ColorManager.grey,
                          height: 10.h,
                        ),
                      ),
                      validator: emailValidator,
                      isLastInput: true,
                    ),
                    SizedBox(
                      height: 0.06.sh,
                    ),
                    BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
                      listener: (context, state) {
                        if (state is ForgetPasswordFailureState) {
                          showMessage(message: state.msg);
                        } else if (state is ForgetPasswordSuccessState) {
                          navigateTo(
                            page: OtpScreen(
                              email: cubit.emailController.text,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is ForgetPasswordLoadingState) {
                          return JumpingDotsProgressIndicator(
                            fontSize: 50.h,
                            color: ColorManager.secMainColor,
                          );
                        }
                        return CustomElevated(
                          text: "إرسال",
                          press: cubit.sendEmail,
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
        },
      ),
    );
  }
}
