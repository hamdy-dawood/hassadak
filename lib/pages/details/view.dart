import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/back_with_search.dart';
import 'package:hassadak/components/custom_elevated.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/favourite/add_fav/cubit.dart';
import 'package:hassadak/pages/reviews/view.dart';
import 'package:progress_indicators/progress_indicators.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({
    Key? key,
    required this.id,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.desc,
    required this.ratingsAverage,
    required this.image,
    required this.ratingsQuantity,
    required this.userImage,
  }) : super(key: key);

  final String id, name, desc, price, oldPrice, image, userImage;
  final num ratingsAverage, ratingsQuantity;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final addFavCubit = AddFavCubit.get(context);
      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: backWithSearch(context),
        body: ListView(
          children: [
            SizedBox(
              height: 0.35.sh,
              child: Center(
                child: CachedNetworkImage(
                  fit: BoxFit.contain,
                  imageUrl: image,
                  placeholder: (context, url) => JumpingDotsProgressIndicator(
                    fontSize: 100.h,
                    color: ColorManager.secMainColor,
                  ),
                  errorWidget: (context, url, error) => Center(
                    child: Image.asset("assets/images/no_image.png"),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 1.sw,
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20.r,
                          child: CachedNetworkImage(
                            fit: BoxFit.contain,
                            imageUrl: userImage,
                            placeholder: (context, url) =>
                                JumpingDotsProgressIndicator(
                              fontSize: 20.h,
                              color: ColorManager.secMainColor,
                            ),
                            errorWidget: (context, url, error) => Center(
                              child: Image.asset("assets/images/user.png"),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        CustomText(
                          text: "محمد احمد",
                          color: ColorManager.mainColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 20.sp,
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            CustomText(
                              text: "$price دينار",
                              color: ColorManager.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                            ),
                            CustomText(
                              text: "$oldPrice دينار",
                              color: ColorManager.navGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              textDecoration: TextDecoration.lineThrough,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomText(
                      text: name,
                      color: ColorManager.mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    InkWell(
                      onTap: () {
                        navigateTo(
                          page: ReviewsView(
                            rating: ratingsAverage,
                            id: id,
                            name: name,
                            image: image,
                          ),
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 5.w),
                            child: SvgIcon(
                              icon: "assets/icons/fill_star.svg",
                              height: 22.h,
                              color: ColorManager.secMainColor,
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          CustomText(
                            text: "$ratingsAverage",
                            color: ColorManager.mainColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.normal,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: SvgIcon(
                              icon: "assets/icons/line.svg",
                              height: 22.h,
                              color: ColorManager.secMainColor,
                            ),
                          ),
                          CustomText(
                            text: "التقييمات",
                            color: ColorManager.mainColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.normal,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Icon(
                            Icons.arrow_back_ios_new,
                            size: 18.sp,
                            color: ColorManager.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.w,
                    ),
                    ExpansionTile(
                      iconColor: ColorManager.grey,
                      initiallyExpanded: false,
                      title: CustomText(
                        text: "تفاصيل المنتج",
                        color: const Color(0xb3464646),
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                      children: [
                        ListTile(
                          title: CustomText(
                            text: desc,
                            color: ColorManager.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomElevated(
                            text: "الذهاب إلى الشراء",
                            press: () {},
                            hSize: 50.h,
                            btnColor: ColorManager.secMainColor,
                            borderRadius: 12.r,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: BlocBuilder<AddFavCubit, AddFavStates>(
                            builder: (context, state) {
                              return CustomElevated(
                                text: "أضف إلى المفضلة",
                                press: () {
                                  addFavCubit.addFav(id: id);
                                },
                                hSize: 50.h,
                                btnColor: ColorManager.backGreyWhite,
                                borderRadius: 12.r,
                                fontSize: 16.sp,
                                textColor: ColorManager.black,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
