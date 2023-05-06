import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/back_with_search.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/constants/shimmer.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/pages/reviews/add_review/cubit.dart';
import 'package:hassadak/pages/reviews/delete_review/cubit.dart';
import 'package:hassadak/pages/reviews/states.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'components/build_bottom_sheef_add_review.dart';
import 'components/build_review_builder.dart';
import 'cubit.dart';

class ReviewsView extends StatelessWidget {
  const ReviewsView({
    Key? key,
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
  }) : super(key: key);
  final String id, name, image;
  final int rating;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final addReviewCubit = AddReviewsCubit.get(context);
        final reviewCubit = ReviewsCubit.get(context);
        final deleteReviewCubit = DeleteReviewsCubit.get(context);
        reviewCubit.getReviews(id: id);
        return RefreshIndicator(
          backgroundColor: ColorManager.secMainColor,
          color: Colors.white,
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            reviewCubit.getReviews(id: id);
          },
          child: Scaffold(
            backgroundColor: ColorManager.white,
            appBar: backWithSearch(context),
            bottomSheet: BuildBottomSheetAddReview(
                addReviewsCubit: addReviewCubit, id: id),
            body: ListView(
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 0.20.sh,
                      width: 0.20.sh,
                      child: Center(
                        child: CachedNetworkImage(
                          imageUrl: image,
                          placeholder: (context, url) =>
                              JumpingDotsProgressIndicator(
                            fontSize: 50.h,
                            color: ColorManager.secMainColor,
                          ),
                          errorWidget: (context, url, error) => Center(
                            child: Image.network(UrlsStrings.noImageUrl),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: name,
                          color: ColorManager.mainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: 0.02.sh,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgIcon(
                              icon: "assets/icons/fill_star.svg",
                              height: 22.h,
                              color: ColorManager.green,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            CustomText(
                              text: "$rating",
                              color: ColorManager.mainColor,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 0.02.sh,
                        ),
                        BlocBuilder<ReviewsCubit, ReviewsStates>(
                          builder: (context, state) {
                            if (state is ReviewsLoadingState) {
                              return ContainerShimmer(
                                height: 20.h,
                                width: 100.w,
                                margin: EdgeInsets.all(0.h),
                                padding: EdgeInsets.all(0.h),
                                radius: 5.r,
                              );
                            } else if (state is ReviewsFailureState) {
                              return Text(state.msg);
                            } else {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomText(
                                    text:
                                        "${reviewCubit.reviewsResponse?.results}",
                                    color: ColorManager.mainColor,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  CustomText(
                                    text: "تقييم",
                                    color: ColorManager.mainColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18.sp,
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  color: ColorManager.navGrey,
                  thickness: 1.5,
                ),
                BuildReviewBuilder(
                  reviewCubit: reviewCubit,
                  deleteReviewCubit: deleteReviewCubit,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}