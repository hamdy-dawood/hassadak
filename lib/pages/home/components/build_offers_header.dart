import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/constants/shimmer.dart';

import '../offers/cubit.dart';

class BuildOfferHeader extends StatelessWidget {
  final AllOffersCubit offersCubit;
  final BuildContext context;

  const BuildOfferHeader({
    super.key,
    required this.offersCubit,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllOffersCubit, AllOffersStates>(
      builder: (context, state) {
        if (state is AllOffersLoadingStates) {
          return SizedBox(
            height: 150.h,
            child: ListView.separated(
                shrinkWrap: true,
                itemCount: 2,
                separatorBuilder: (context, index) => SizedBox(
                      width: 5.w,
                    ),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ContainerShimmer(
                    height: 150.h,
                    width: 0.85.sw,
                    margin: EdgeInsets.only(
                      top: 25.h,
                      bottom: 10.h,
                      right: 10.w,
                    ),
                    padding: EdgeInsets.all(12.h),
                  );
                }),
          );
        } else if (state is AllOffersFailedStates) {
          return Text(state.msg);
        } else {
          return SizedBox(
            height: 150.h,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: offersCubit.allOffers!.data.doc.length,
              separatorBuilder: (context, index) => SizedBox(
                width: 5.w,
              ),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final offers = offersCubit.allOffers!.data.doc[index];
                return Container(
                  height: 150.h,
                  width: 0.85.sw,
                  margin: EdgeInsets.only(
                    top: 25.h,
                    bottom: 10.h,
                    right: 10.w,
                  ),
                  padding: EdgeInsets.all(12.h),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorManager.secMainColor,
                        ColorManager.lightMainColor,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Image.asset(
                          "assets/images/offer.png",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomText(
                              text: offers.name,
                              color: ColorManager.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            CustomText(
                              text: offers.desc,
                              color: ColorManager.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ],
                        ),
                      )
                    ],
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
