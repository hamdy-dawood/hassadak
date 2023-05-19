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
import 'package:url_launcher/url_launcher.dart';

class DetailsView extends StatefulWidget {
  const DetailsView({
    Key? key,
    required this.id,
    required this.productName,
    required this.price,
    required this.oldPrice,
    required this.desc,
    required this.ratingsAverage,
    required this.image,
    required this.ratingsQuantity,
    required this.userImage,
    required this.userName,
    required this.phone,
    required this.favStatus,
  }) : super(key: key);

  final String id,
      productName,
      desc,
      price,
      oldPrice,
      image,
      userImage,
      userName,
      phone;
  final num ratingsAverage, ratingsQuantity;
  final bool favStatus;

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  bool myBool = false;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

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
                  imageUrl: widget.image,
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
                        ClipOval(
                          child: CircleAvatar(
                            radius: 20.r,
                            backgroundColor: ColorManager.mainColor,
                            child: CachedNetworkImage(
                              fit: BoxFit.contain,
                              imageUrl: widget.userImage,
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
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        CustomText(
                          text: widget.userName,
                          color: ColorManager.mainColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 20.sp,
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            CustomText(
                              text: "${widget.price} دينار",
                              color: ColorManager.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                            ),
                            CustomText(
                              text: "${widget.oldPrice} دينار",
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
                      text: widget.productName,
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
                            rating: widget.ratingsAverage,
                            id: widget.id,
                            name: widget.productName,
                            image: widget.image,
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
                            text: "${widget.ratingsAverage}",
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
                      height: 10.h,
                    ),
                    ExpansionTile(
                      iconColor: const Color(0xb3464646),
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
                            text: widget.desc,
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
                      height: 50.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomElevated(
                            text: "الذهاب إلى الشراء",
                            press: () {
                              _launchInBrowser(Uri.parse(
                                  "https://api.whatsapp.com/send/?phone=%2B2${widget.phone}"));
                            },
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
                                text: myBool == widget.favStatus
                                    ? "أضف إلى المفضلة"
                                    : "مضاف للمفضلة",
                                hSize: 50.h,
                                btnColor: ColorManager.backGreyWhite,
                                borderRadius: 12.r,
                                fontSize: 16.sp,
                                textColor: myBool == widget.favStatus
                                    ? Colors.black
                                    : ColorManager.green,
                                press: () {
                                  if (myBool == widget.favStatus) {
                                    addFavCubit.addFav(id: widget.id);
                                    myBool = true;
                                    setState(() {});
                                  }
                                },
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
