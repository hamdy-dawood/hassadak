import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/custom_elevated.dart';
import 'package:hassadak/components/error_network.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/constants/shimmer.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/profile/personal_data/cubit.dart';
import 'package:hassadak/pages/profile/personal_data/states.dart';
import 'package:hassadak/pages/reviews/cubit.dart';
import 'package:hassadak/pages/reviews/delete_review/cubit.dart';
import 'package:hassadak/pages/reviews/delete_review/states.dart';
import 'package:hassadak/pages/reviews/states.dart';
import 'package:progress_indicators/progress_indicators.dart';

class BuildReviewBuilder extends StatelessWidget {
  const BuildReviewBuilder({
    Key? key,
    required this.reviewCubit,
    required this.deleteReviewCubit,
  }) : super(key: key);
  final ReviewsCubit reviewCubit;
  final DeleteReviewsCubit deleteReviewCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsCubit, ReviewsStates>(
      builder: (context, state) {
        if (state is ReviewsLoadingState) {
          return SizedBox(
            height: 0.75.sh,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return ContainerShimmer(
                    height: 120.h,
                    width: 0.85.sw,
                    margin: EdgeInsets.only(
                      bottom: 10.h,
                      right: 12.w,
                      left: 12.w,
                    ),
                    padding: EdgeInsets.all(12.h),
                  );
                }),
          );
        } else if (state is ReviewsFailureState) {
          return Text(state.msg);
        } else if (state is ReviewsNetworkErrorState) {
          return const ErrorNetwork();
        } else {
          return SizedBox(
            height: 1.sh,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: reviewCubit.reviewsResponse?.data!.doc!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onLongPress: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15.r),
                          topLeft: Radius.circular(15.r),
                        ),
                      ),
                      builder: (context) => SizedBox(
                        height: 130.h,
                        width: 1.sw,
                        child: Padding(
                          padding: EdgeInsets.all(30.h),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5.h,
                              ),
                              CustomElevated(
                                text: "حذف",
                                borderRadius: 12.r,
                                btnColor: ColorManager.secMainColor,
                                fontSize: 20.sp,
                                press: () {
                                  showDialog(
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          title: CustomText(
                                            text: "حذف التعليق",
                                            color: ColorManager.mainColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22.sp,
                                          ),
                                          content: CustomText(
                                            text:
                                            "هل انت متأكد من حذف التعليق؟",
                                            color: ColorManager.mainColor,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 18.sp,
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: CustomText(
                                                text: "الغاء",
                                                fontSize: 18.sp,
                                                color:
                                                ColorManager.navGrey,
                                                fontWeight:
                                                FontWeight.normal,
                                              ),
                                            ),
                                            BlocConsumer<
                                                DeleteReviewsCubit,
                                                DeleteReviewsStates>(
                                              listener: (context, state) {
                                                if (state
                                                is DeleteReviewsFailureState) {
                                                  Navigator.pop(context);
                                                  showMessage(
                                                      message:
                                                      "فشل الحذف");
                                                } else if (state
                                                is DeleteReviewsSuccessState) {
                                                  return Navigator.pop(
                                                      context);
                                                }
                                              },
                                              builder: (context, state) {
                                                if (state
                                                is DeleteReviewsLoadingState) {
                                                  return JumpingDotsProgressIndicator(
                                                    fontSize: 50.h,
                                                    color: ColorManager
                                                        .secMainColor,
                                                  );
                                                }
                                                return CustomElevated(
                                                  press: () {
                                                    deleteReviewCubit
                                                        .deleteReview(
                                                        id: "${reviewCubit.reviewsResponse!.data!.doc![index].id}");
                                                    showMessage(
                                                        message:
                                                        "تم الحذف");
                                                  },
                                                  text: "حذف",
                                                  wSize: 100.w,
                                                  hSize: 40.sp,
                                                  borderRadius: 5.r,
                                                  btnColor:
                                                  ColorManager.red,
                                                );
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                      context: context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(20.w),
                    margin: EdgeInsets.symmetric(
                        vertical: 10.h, horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.lightMainColor,
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        BlocBuilder<PersonalDataCubit,
                            PersonalDataStates>(
                          builder: (context, state) {
                            if (state is PersonalDataLoadingState) {
                              return ContainerShimmer(
                                height: 50.h,
                                width: 1.sw,
                                margin: EdgeInsets.all(0.h),
                                padding: EdgeInsets.all(0.h),
                                radius: 5.r,
                              );
                            } else if (state
                            is PersonalDataFailureState) {
                              return Text(state.msg);
                            } else {
                              return Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30.r,
                                    backgroundColor:
                                    ColorManager.secMainColor,
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                        fit: BoxFit.contain,
                                        imageUrl:
                                        "${reviewCubit.reviewsResponse?.data!.doc![index].image}",
                                        placeholder: (context, url) =>
                                            JumpingDotsProgressIndicator(
                                              fontSize: 20.h,
                                              color:
                                              ColorManager.secMainColor,
                                            ),
                                        errorWidget: (context, url,
                                            error) =>
                                            Center(
                                                child: Image.network(
                                                    UrlsStrings
                                                        .userImageUrl)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text:
                                        "${reviewCubit.reviewsResponse?.data!.doc![index].userName}",
                                        color: ColorManager.mainColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18.sp,
                                      ),
                                      SizedBox(
                                        height: 5.w,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: List.generate(
                                          reviewCubit.reviewsResponse!
                                              .data!.doc![index].rating!
                                              .toInt(),
                                              (index) => Padding(
                                            padding: EdgeInsets.only(
                                                left: 5.w),
                                            child: SvgIcon(
                                              icon:
                                              "assets/icons/fill_star.svg",
                                              height: 20.h,
                                              color: ColorManager.green,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        CustomText(
                                          text:
                                          "${reviewCubit.reviewsResponse?.data!.doc![index].updatedAt}"
                                              .split("T")[0],
                                          color: ColorManager.grey,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16.sp,
                                          maxLines: 1,
                                        ),
                                        SizedBox(height: 5.h),
                                        CustomText(
                                          text:
                                          "${reviewCubit.reviewsResponse?.data!.doc![index].updatedAt}"
                                              .split("T")[1]
                                              .split(".")[0],
                                          color: ColorManager.grey,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16.sp,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Divider(
                            color: ColorManager.navGrey,
                            thickness: 1,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: CustomText(
                            text:
                            "${reviewCubit.reviewsResponse?.data!.doc![index].review}",
                            color: ColorManager.brown,
                            fontWeight: FontWeight.normal,
                            fontSize: 20.sp,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
