import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/custom_elevated.dart';
import 'package:hassadak/components/error_network.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/constants/input_validator.dart';
import 'package:hassadak/core/cache_helper.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/bottom_nav_bar/view.dart';
import 'package:hassadak/pages/profile/components/build_text_field_with_text.dart';
import 'package:hassadak/pages/profile/personal_data/cubit.dart';
import 'package:hassadak/pages/profile/personal_data/states.dart';
import 'package:hassadak/pages/upload_photo/view.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shimmer/shimmer.dart';

import 'cubit.dart';
import 'states.dart';

class EditDataView extends StatelessWidget {
  const EditDataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final editCubit = EditDataCubit.get(context);
      final myDataCubit = PersonalDataCubit.get(context);

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
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgIcon(
                icon: "assets/icons/edit.svg",
                height: 20.h,
                color: ColorManager.green,
              ),
            ),
          ],
          title: CustomText(
            text: "تعديل البيانات",
            color: ColorManager.mainColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: SizedBox(
          width: 1.sw,
          height: 1.sh,
          child: Form(
            key: editCubit.formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: BlocBuilder<PersonalDataCubit, PersonalDataStates>(
                builder: (context, state) {
                  if (state is PersonalDataLoadingState) {
                    return SizedBox(
                      height: 1.sh,
                      child: Shimmer.fromColors(
                        baseColor: ColorManager.shimmerBaseColor,
                        highlightColor: ColorManager.shimmerHighlightColor,
                        direction: ShimmerDirection.rtl,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              CircleAvatar(
                                radius: 60.r,
                                backgroundColor: ColorManager.shimmerBaseColor,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                height: 20.h,
                                width: 150.w,
                                color: ColorManager.shimmerBaseColor,
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  5,
                                  (index) => Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          height: 15.h,
                                          width: 150.w,
                                          color: ColorManager.shimmerBaseColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Container(
                                        height: 50.h,
                                        width: 300.w,
                                        decoration: BoxDecoration(
                                          color: ColorManager.shimmerBaseColor,
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else if (state is NetworkErrorState) {
                    return ErrorNetwork(press: () {
                      myDataCubit.getPersonalData(id: CacheHelper.getId());
                    });
                  } else if (state is PersonalDataFailureState) {
                    return Center(child: Text(state.msg));
                  } else {
                    final data = myDataCubit.profileResponse!.data!.doc!;
                    return ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 8.h),
                                    height: 100.h,
                                    width: 100.h,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      color: ColorManager.secMainColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.contain,
                                      imageUrl: "${data.userPhoto}",
                                      placeholder: (context, url) =>
                                          JumpingDotsProgressIndicator(
                                        fontSize: 20.h,
                                        color: ColorManager.white,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Center(
                                              child: Image.asset(
                                                  "assets/images/user.png")),
                                    ),
                                  ),
                                  CustomText(
                                    textAlign: TextAlign.center,
                                    text: "${data.firstName} ${data.lastName}",
                                    color: ColorManager.secMainColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18.sp,
                                  ),
                                ],
                              ),
                              SizedBox(width: 20.w),
                              Expanded(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  child: CustomElevated(
                                    text: "تعديل الصورة",
                                    press: () {
                                      navigateTo(
                                          page: const UploadUserPhotoView());
                                    },
                                    wSize: 120.w,
                                    hSize: 30.h,
                                    btnColor: ColorManager.secMainColor,
                                    borderRadius: 10.r,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 0.04.sh,
                        ),
                        TextFieldWithText(
                          controller: editCubit.controllers.firstNameController,
                          title: "الاسم الاول",
                          hint: "${data.firstName}",
                          validator: firstNameValidator,
                        ),
                        TextFieldWithText(
                          controller: editCubit.controllers.lastNameController,
                          title: "الاسم الاخير",
                          hint: "${data.lastName}",
                          validator: lastNameValidator,
                        ),
                        TextFieldWithText(
                          controller: editCubit.controllers.userNameController,
                          title: "اسم المستخدم",
                          hint: "${data.username}",
                          validator: userNameValidator,
                        ),
                        TextFieldWithText(
                          controller: editCubit.controllers.phoneController,
                          title: "رقم الهاتف",
                          hint: "${data.telephone}",
                          validator: phoneValidator,
                        ),
                        SizedBox(
                          height: 0.02.sh,
                        ),
                        BlocConsumer<EditDataCubit, EditDataStates>(
                          listener: (context, state) {
                            if (state is EditDataFailureState) {
                              showMessage(
                                  message: state.msg,
                                  height: 60.h,
                                  maxLines: 5);
                            } else if (state is EditNetworkErrorState) {
                              showMessage(message: "يرجي التحقق من الانترنت");
                            } else if (state is EditDataSuccessState) {
                              showMessage(message: "تم التعدبل");
                              navigateTo(
                                  page: const NavBarView(), withHistory: false);
                            }
                          },
                          builder: (context, state) {
                            if (state is EditDataLoadingState) {
                              return JumpingDotsProgressIndicator(
                                fontSize: 50.h,
                                color: ColorManager.secMainColor,
                              );
                            }
                            return CustomElevated(
                              text: "تعديل",
                              press: () {
                                editCubit.getEditData();
                              },
                              hSize: 50.h,
                              btnColor: ColorManager.secMainColor,
                              borderRadius: 20.r,
                              fontSize: 18.sp,
                            );
                          },
                        ),
                        SizedBox(
                          height: 0.05.sh,
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}
