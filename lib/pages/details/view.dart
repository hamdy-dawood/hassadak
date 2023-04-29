import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/custom_elevated.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/search/view.dart';
import 'package:progress_indicators/progress_indicators.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({
    Key? key,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.desc,
    required this.rating,
    required this.image,
  }) : super(key: key);

  final String name, desc, price, oldPrice, image;
  final int rating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0.2,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: 22.sp,
              color: ColorManager.black,
            ),
          ),
        ],
        leading: InkWell(
          onTap: () {
            navigateTo(page: const SearchView());
          },
          child: Padding(
            padding: EdgeInsets.all(13.w),
            child: SvgIcon(
              icon: "assets/icons/search.svg",
              height: 20.h,
              color: ColorManager.red,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 0.35.sh,
            child: Center(
              child: CachedNetworkImage(
                imageUrl: image,
                placeholder: (context, url) => JumpingDotsProgressIndicator(
                  fontSize: 50.h,
                  color: ColorManager.secMainColor,
                ),
                errorWidget: (context, url, error) => Center(
                  child: Image.network(UrlsStrings.noImageUrl),
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
                        backgroundImage: const AssetImage(
                          "assets/images/user.png",
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      CustomText(
                        text: "محمد عبدالله",
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
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      rating,
                      (index) => Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child: SvgIcon(
                          icon: "assets/icons/fill_star.svg",
                          height: 20.h,
                        ),
                      ),
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
                        child: CustomElevated(
                          text: "أضف إلى المفضلة",
                          press: () {},
                          hSize: 50.h,
                          btnColor: ColorManager.backGreyWhite,
                          borderRadius: 12.r,
                          fontSize: 16.sp,
                          textColor: ColorManager.black,
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
  }
}
