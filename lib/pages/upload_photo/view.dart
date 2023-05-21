import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/custom_elevated.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/bottom_nav_bar/view.dart';
import 'package:hassadak/pages/upload_photo/states.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'cubit.dart';

class UploadUserPhotoView extends StatelessWidget {
  const UploadUserPhotoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UploadUserPhotoCubit(),
      child: Builder(builder: (context) {
        final cubit = UploadUserPhotoCubit.get(context);

        return Scaffold(
          backgroundColor: ColorManager.white,
          body: SizedBox(
            width: 1.sw,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                    child: SvgIcon(
                      icon: "assets/icons/logo.svg",
                      color: ColorManager.green,
                      height: 50.h,
                    ),
                  ),
                  SizedBox(
                    height: 0.05.sh,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CustomText(
                      text: "اصف الصورة الخاصة بك",
                      color: ColorManager.secMainColor,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 0.1.sh,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15.r),
                              topLeft: Radius.circular(15.r),
                            ),
                          ),
                          builder: (context) {
                            return SizedBox(
                              height: 120.h,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 50.h,
                                    width: 50.h,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: ColorManager.mainColor,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          cubit.chooseMyImage(
                                              source: ImageSource.gallery);
                                        },
                                        child: Icon(
                                          color: ColorManager.secMainColor,
                                          Icons.image,
                                          size: 30.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 50.h,
                                    width: 50.h,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: ColorManager.mainColor,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          cubit.chooseMyImage(
                                              source: ImageSource.camera);
                                        },
                                        child: Icon(
                                          color: ColorManager.secMainColor,
                                          Icons.camera_alt,
                                          size: 30.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    child: BlocBuilder<UploadUserPhotoCubit,
                        UploadUserPhotoStates>(builder: (context, state) {
                      return Container(
                        height: 140.h,
                        width: 140.h,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: ColorManager.secMainColor,
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            if (cubit.myImage != null)
                              Image.file(
                                cubit.myImage!,
                                fit: BoxFit.cover,
                              ),
                            cubit.myImage != null
                                ? const SizedBox()
                                : Icon(
                                    Icons.camera_alt_outlined,
                                    size: 40.sp,
                                    color: ColorManager.white,
                                  ),
                          ],
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: 0.05.sh,
                  ),
                  BlocConsumer<UploadUserPhotoCubit, UploadUserPhotoStates>(
                    listener: (context, state) {
                      if (state is UploadUserPhotoFailureState) {
                        showMessage(
                            message: state.msg, height: 60.h, maxLines: 5);
                      } else if (state is UploadUserPhotoSuccessState) {
                        navigateTo(
                            page: const NavBarView(), withHistory: false);
                      }
                    },
                    builder: (context, state) {
                      if (state is UploadUserPhotoLoadingState) {
                        return JumpingDotsProgressIndicator(
                          fontSize: 50.h,
                          color: ColorManager.secMainColor,
                        );
                      }
                      return CustomElevated(
                        text: "التالي",
                        press: () {
                          print( cubit.myImage!);
                          cubit.uploadPhoto();
                        },
                        hSize: 50.h,
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
