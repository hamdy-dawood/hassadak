import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/custom_elevated.dart';
import 'package:hassadak/components/custom_form_field.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';

import 'cubit.dart';
import 'states.dart';

class NewPasswordView extends StatelessWidget {
  const NewPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewPasswordCubit(),
      child: Builder(
        builder: (context) {
          final cubit = NewPasswordCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: cubit.formKey,
                child: SingleChildScrollView(
                  child: Column(
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
                      SizedBox(
                        height: 0.05.sh,
                      ),
                      BlocBuilder<NewPasswordCubit, NewPasswordStates>(
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
                      BlocBuilder<NewPasswordCubit, NewPasswordStates>(
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
                              } else if (value !=
                                  cubit.passwordController.text) {
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
                      BlocConsumer<NewPasswordCubit, NewPasswordStates>(
                        listener: (context, state) {
                          if (state is NewPasswordFailureState) {
                            // return showSnackBar(context, state.msg);
                          } else if (state is NewPasswordSuccessState) {
                            // return navigateTo(
                            //     page: const MoviesView(), withHistory: false);
                          }
                        },
                        builder: (context, state) {
                          if (state is NewPasswordLoadingState) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return CustomElevated(
                            text: "تأكيد",
                            press: cubit.newPassword,
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
            ),
          );
        },
      ),
    );
  }
}
