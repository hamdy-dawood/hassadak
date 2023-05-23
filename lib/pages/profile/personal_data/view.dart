import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/build_cache_image.dart';
import 'package:hassadak/components/custom_elevated.dart';
import 'package:hassadak/components/error_network.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/core/cache_helper.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/profile/components/build_text_field_with_text.dart';
import 'package:hassadak/pages/profile/edit_data/view.dart';
import 'package:hassadak/pages/profile/personal_data/states.dart';
import 'package:hassadak/pages/upload_photo/view.dart';
import 'package:shimmer/shimmer.dart';

import 'cubit.dart';

class PersonalDataView extends StatelessWidget {
  const PersonalDataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final cubit = PersonalDataCubit.get(context);
      cubit.getPersonalData(id: CacheHelper.getId());
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
              onPressed: () {
                navigateTo(page: const EditDataView());
              },
              icon: SvgIcon(
                icon: "assets/icons/edit.svg",
                height: 20.h,
                color: ColorManager.black,
              ),
            ),
          ],
          title: CustomText(
            text: "معلوماتى الشخصية",
            color: ColorManager.mainColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: SizedBox(
          width: 1.sw,
          height: 1.sh,
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
                    cubit.getPersonalData(id: CacheHelper.getId());
                  });
                } else if (state is PersonalDataFailureState) {
                  return Center(child: Text(state.msg));
                } else {
                  final cubitData = cubit.profileResponse!.data!.doc;
                  return ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  child: BuildCacheImage(
                                    imageUrl: "${cubitData!.userPhoto}",
                                    height: 100.h,
                                    loadingHeight: 40.h,
                                  ),
                                ),
                                CustomText(
                                  textAlign: TextAlign.center,
                                  text:
                                      "${cubitData.firstName} ${cubitData.lastName}",
                                  color: ColorManager.secMainColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.sp,
                                ),
                              ],
                            ),
                            SizedBox(width: 20.w),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                        height: 0.02.sh,
                      ),
                      TextFieldWithText(
                        title: "الاسم الاول",
                        hint: "${cubitData.firstName}",
                        titleColor: ColorManager.grey,
                      ),
                      TextFieldWithText(
                        title: "الاسم الاخير",
                        hint: "${cubitData.lastName}",
                        titleColor: ColorManager.grey,
                      ),
                      TextFieldWithText(
                        title: "اسم المستخدم",
                        hint: "${cubitData.username}",
                        titleColor: ColorManager.grey,
                      ),
                      TextFieldWithText(
                        title: "رقم الهاتف",
                        hint: "${cubitData.telephone}",
                        titleColor: ColorManager.grey,
                      ),
                      TextFieldWithText(
                        title: "البريد الالكترونى",
                        hint: "${cubitData.email}",
                        titleColor: ColorManager.grey,
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      );
    });
  }
}
