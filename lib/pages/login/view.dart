import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/custom_elevated.dart';
import 'package:hassadak/components/custom_form_field.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/bottom_nav_bar/view.dart';
import 'package:hassadak/pages/forget_password/view.dart';
import 'package:hassadak/pages/login/states.dart';
import 'package:hassadak/pages/register/view.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final cubit = LoginCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: cubit.formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: ListView(
                children: [
                  SizedBox(
                    height: 0.1.sh,
                  ),
                  SvgIcon(
                    icon: "assets/icons/logo.svg",
                    color: ColorManager.green,
                    height: 80.h,
                  ),
                  SizedBox(
                    height: 0.02.sh,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.03.sh),
                    child: Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        text: "اهلا بك في تطبيق حصادك",
                        color: ColorManager.mainColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.04.sh,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CustomText(
                      text: "قم الان بتسجيل الدخول",
                      color: ColorManager.secMainColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 0.02.sh,
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل الايميل !';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 0.02.sh,
                  ),
                  BlocBuilder<LoginCubit, LoginStates>(
                    builder: (context, state) {
                      return CustomTextFormField(
                        controller: cubit.passwordController,
                        hint: 'كلمة المرور',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(8.0.w),
                          child: SvgIcon(
                            icon: "assets/icons/lock.svg",
                            color: ColorManager.grey,
                            height: 10.h,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'من فضلك ادخل كلمة المرور !';
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          onPressed: () {
                            cubit.changeVisibility();
                          },
                          icon: Icon(
                            cubit.isObscure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                          color: ColorManager.grey,
                        ),
                        obscureText: cubit.isObscure,
                        isLastInput: true,
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: TextButton(
                      onPressed: () {
                        navigateTo(page: const ForgetPasswordView());
                      },
                      child: CustomText(
                        text: "هل نسيت كلمة المرور؟",
                        color: ColorManager.green,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.05.sh,
                  ),
                  BlocConsumer<LoginCubit, LoginStates>(
                    listener: (context, state) {
                      if (state is LoginFailureState) {
                        showMessage(message: "فشل تسجيل الدخول");
                      } else if (state is LoginSuccessState) {
                        navigateTo(page: NavBarView(), withHistory: false);
                      }
                    },
                    builder: (context, state) {
                      if (state is LoginLoadingState) {
                        return JumpingDotsProgressIndicator(
                          fontSize: 50.h,
                          color: ColorManager.secMainColor,
                        );
                      }
                      return CustomElevated(
                        text: "تسجيل الدخول",
                        press: cubit.login,
                        hSize: 50.h,
                        btnColor: ColorManager.secMainColor,
                        borderRadius: 20.r,
                        fontSize: 18.sp,
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "ليس لديك حساب ؟",
                        color: ColorManager.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.normal,
                      ),
                      TextButton(
                        onPressed: () {
                          navigateTo(
                            page: const RegisterView(),
                          );
                        },
                        child: CustomText(
                          text: "اضافة حساب",
                          color: ColorManager.green,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
