import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';

import 'custom_elevated.dart';

class SpecialOfferItem extends StatelessWidget {
  const SpecialOfferItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 160.h,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                      text:
                          "مبيد لمبادا تركيز 10% للذبابة الببضاء وذبابة الفاكهة",
                      color: ColorManager.mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15.r,
                            backgroundImage:
                                const AssetImage("assets/images/user.png"),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          CustomText(
                            text: "محمد احمد",
                            color: ColorManager.mainColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 15.sp,
                          ),
                          const Spacer(),
                          CustomElevated(
                            text: "خصم 20%",
                            btnColor: ColorManager.green,
                            press: () {},
                            borderRadius: 25.r,
                            wSize: 90.w,
                            hSize: 30.h,
                            fontSize: 15.sp,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        CustomText(
                          text: "${666} ج.م",
                          color: ColorManager.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                        const Spacer(),
                        CustomText(
                          text: "${599} ج.م",
                          color: ColorManager.navGrey,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                          textDecoration: TextDecoration.lineThrough,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 5.w),
                child: SizedBox(
                  height: 90.h,
                  width: 70.h,
                  child: Image.asset(
                    "assets/images/fav_product.png",
                    fit: BoxFit.contain,
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
