import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/back_with_logo.dart';
import 'package:hassadak/components/custom_elevated.dart';
import 'package:hassadak/components/custom_form_field.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/bottom_nav_bar/view.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'cubit.dart';
import 'states.dart';

class UpdatePasswordView extends StatelessWidget {
  const UpdatePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdatePasswordCubit(),
      child: Builder(
        builder: (context) {
          final cubit = UpdatePasswordCubit.get(context);
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
                        text: "كلمة مرور جديدة",
                        color: ColorManager.secMainColor,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    CustomText(
                      text: "قم بإنشاء كلمة مرور جديدة لتسجيل الدخول",
                      color: ColorManager.grey,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                    BlocBuilder<UpdatePasswordCubit, UpdatePasswordStates>(
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
                      height: 0.05.sh,
                    ),
                    BlocBuilder<UpdatePasswordCubit, UpdatePasswordStates>(
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
                    BlocBuilder<UpdatePasswordCubit, UpdatePasswordStates>(
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
                              return 'من فضلك ادخل تأكيد كلمة المرور !';
                            } else if (value != cubit.passwordController.text) {
                              return 'كلمة المرور ليست مطابقة !';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 0.04.sh,
                    ),
                    BlocConsumer<UpdatePasswordCubit, UpdatePasswordStates>(
                      listener: (context, state) {
                        if (state is UpdatePasswordFailureState) {
                          showMessage(message: state.msg);
                        } else if (state is UpdatePasswordSuccessState) {
                          showMessage(message: "success");
                          // return navigateTo(
                          //     page: NavBarView(), withHistory: false);
                        }
                      },
                      builder: (context, state) {
                        if (state is UpdatePasswordLoadingState) {
                          return JumpingDotsProgressIndicator(
                            fontSize: 50.h,
                            color: ColorManager.secMainColor,
                          );
                        }
                        return CustomElevated(
                          text: "تأكيد",
                          press: cubit.updatePassword,
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
