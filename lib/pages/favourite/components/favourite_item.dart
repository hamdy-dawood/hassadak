import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hassadak/components/custom_elevated.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:progress_indicators/progress_indicators.dart';

class FavouriteItem extends StatelessWidget {
  const FavouriteItem({
    Key? key,
    required this.offer,
    required this.image,
    required this.title,
    required this.userName,
    required this.userImage,
    required this.price,
    required this.oldPrice,
    required this.deleteTap,
    required this.isOffer,
  }) : super(key: key);

  final String offer, image, title, userName, userImage, price, oldPrice;
  final SlidableActionCallback deleteTap;
  final bool isOffer;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: deleteTap,
            backgroundColor: ColorManager.white,
            foregroundColor: ColorManager.red,
            icon: Icons.cancel,
          ),
        ],
      ),
      child: Container(
        width: 0.95.sw,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: ColorManager.navGrey,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.h),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: title,
                      color: ColorManager.mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15.r,
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
                          Expanded(
                            child: CustomText(
                              text: userName,
                              color: ColorManager.mainColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 15.sp,
                            ),
                          ),
                          isOffer
                              ? CustomElevated(
                                  text: offer,
                                  btnColor: ColorManager.green,
                                  press: () {},
                                  borderRadius: 25.r,
                                  wSize: 90.w,
                                  hSize: 30.h,
                                  fontSize: 12.sp,
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomText(
                            text: "$price دينار",
                            color: ColorManager.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                        const Spacer(),
                        isOffer
                            ? Expanded(
                                child: CustomText(
                                  text: "$oldPrice دينار",
                                  color: ColorManager.navGrey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                  textDecoration: TextDecoration.lineThrough,
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.w),
                child: SizedBox(
                  height: 100.h,
                  width: 70.h,
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: image.replaceAll(
                        "https://mobizil.com/oppo-f3-specs/",
                        UrlsStrings.noImageUrl),
                    placeholder: (context, url) => JumpingDotsProgressIndicator(
                      fontSize: 50.h,
                      color: ColorManager.secMainColor,
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: Image.asset("assets/images/no_image.png"),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
