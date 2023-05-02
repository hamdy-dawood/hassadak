import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/custom_elevated.dart';
import 'package:hassadak/components/custom_form_field.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'components/build_text_field.dart';
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
            backgroundColor: ColorManager.white,
            appBar: AppBar(
              backgroundColor: ColorManager.white,
              elevation: 0.0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SvgIcon(
                  icon: "assets/icons/arrow.svg",
                  height: 18.h,
                  color: ColorManager.black,
                ),
              ),
              title: CustomText(
                text: "تغيير كلمة المرور",
                color: ColorManager.mainColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: cubit.formKey,
                child: ListView(
                  children: [
                    SizedBox(
                      height: 0.06.sh,
                    ),
                    BuildTextField(
                      controller: cubit.currentPasswordController,
                      hint: "كلمة المرور الحالية",
                      suffixPress: () {
                        cubit.currentPassVisibility();
                      },
                      visibility: cubit.currentPass,
                    ),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    BuildTextField(
                      controller: cubit.passwordController,
                      hint: "كلمة المرور ",
                      suffixPress: () {
                        cubit.passwordVisibility();
                      },
                      visibility: cubit.securePass,
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
                          text: "حفظ",
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
