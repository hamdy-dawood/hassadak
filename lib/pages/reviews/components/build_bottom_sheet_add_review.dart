import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hassadak/components/custom_elevated.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/reviews/add_review/cubit.dart';
import 'package:hassadak/pages/reviews/add_review/states.dart';
import 'package:progress_indicators/progress_indicators.dart';

class BuildBottomSheetAddReview extends StatelessWidget {
  const BuildBottomSheetAddReview(
      {Key? key, required this.addReviewsCubit, required this.id})
      : super(key: key);

  final AddReviewsCubit addReviewsCubit;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: addReviewsCubit.formKey,
      child: SizedBox(
        height: 80.h,
        width: 1.sw,
        child: Center(
          child: CustomElevated(
            text: "اكتب تقييما",
            press: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                backgroundColor: ColorManager.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.r),
                    topLeft: Radius.circular(15.r),
                  ),
                ),
                builder: (context) => Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: SizedBox(
                    height: 0.45.sh,
                    width: 1.sw,
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: 30.h, left: 30.h, bottom: 20.h, top: 10.h),
                      child: ListView(
                        children: [
                          CustomText(
                            text: "اكتب تقييما",
                            color: ColorManager.mainColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          CustomText(
                            text: "ضع تقييما",
                            color: ColorManager.mainColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 18.sp,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          SizedBox(
                            width: 1.sw,
                            child: Center(
                              child: RatingBar.builder(
                                initialRating: 0,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 5.w),
                                itemBuilder: (context, _) => SvgIcon(
                                  icon: "assets/icons/fill_star.svg",
                                  height: 20.h,
                                  color: ColorManager.green,
                                ),
                                onRatingUpdate: (rating) {
                                  addReviewsCubit.rate = rating;
                                  print(rating);
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          SizedBox(
                            height: 100.h,
                            width: 1.sw,
                            child: TextField(
                              controller: addReviewsCubit.reviewController,
                              maxLines: null,
                              expands: true,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ColorManager.lightGrey,
                                hintText: "اكتب تعليقك ....",
                                hintStyle: GoogleFonts.almarai(
                                  textStyle: TextStyle(
                                    color: ColorManager.grey,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ColorManager.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(12.r)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ColorManager.mainColor,
                                    ),
                                    borderRadius: BorderRadius.circular(12.r)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          BlocConsumer<AddReviewsCubit, AddReviewsStates>(
                            listener: (context, state) {
                              if (state is AddReviewsFailureState) {
                                showMessage(message: "فشل الارسال");
                                print(state.msg);
                              } else if (state is AddReviewsSuccessState) {
                                showMessage(message: "تم الارسال");
                                return Navigator.pop(context);
                              }
                            },
                            builder: (context, state) {
                              if (state is AddReviewsLoadingState) {
                                return JumpingDotsProgressIndicator(
                                  fontSize: 50.h,
                                  color: ColorManager.secMainColor,
                                );
                              }
                              return CustomElevated(
                                text: "إرسال",
                                borderRadius: 12.r,
                                btnColor: ColorManager.secMainColor,
                                wSize: 1.sw,
                                press: () {
                                  addReviewsCubit.addReview(
                                    productID: id,
                                  );
                                },
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
            btnColor: ColorManager.secMainColor,
            hSize: 50.h,
            wSize: 0.8.sw,
            borderRadius: 20.r,
            fontSize: 20.sp,
          ),
        ),
      ),
    );
  }
}
