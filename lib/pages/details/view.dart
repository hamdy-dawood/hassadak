import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hassadak/components/back_with_search.dart';
import 'package:hassadak/components/build_cache_image.dart';
import 'package:hassadak/components/custom_elevated.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/favourite/add_fav/cubit.dart';
import 'package:hassadak/pages/reviews/view.dart';
import 'package:hassadak/pages/sellers/get_seller/view.dart';
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
    required this.telephone,
    required this.whatsapp,
    required this.favStatus,
    required this.isOffer,
    required this.uploaderId,
  }) : super(key: key);

  final String id,
      productName,
      desc,
      price,
      oldPrice,
      image,
      userImage,
      userName,
      telephone,
      whatsapp,
      uploaderId;
  final num ratingsAverage, ratingsQuantity;
  final bool favStatus, isOffer;

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

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    double number = double.parse(widget.oldPrice);
    String formatOldPrice = number.toStringAsFixed(2);
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
                    InkWell(
                      onTap: () {
                        navigateTo(
                          page: GetSellerView(
                            id: widget.uploaderId,
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          BuildCacheCircleImage(
                            imageUrl: widget.userImage,
                            height: 40.h,
                            loadingHeight: 20.h,
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CustomText(
                                  text: "${widget.price} ج.م",
                                  color: ColorManager.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 5.h),
                                widget.isOffer
                                    ? CustomText(
                                        text: "$formatOldPrice ج.م",
                                        color: ColorManager.navGrey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                        textDecoration:
                                            TextDecoration.lineThrough,
                                        maxLines: 1,
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
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
                            maxLines: 10,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 50.h,
                                            width: 50.h,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: ColorManager.mainColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10.r,
                                              ),
                                            ),
                                            child: Center(
                                              child: GestureDetector(
                                                onTap: () {
                                                  _launchInBrowser(Uri.parse(
                                                      "https://api.whatsapp.com/send/?phone=%2B2${widget.telephone}"));
                                                },
                                                child: SvgPicture.asset(
                                                  "assets/icons/whatsapp.svg",
                                                  height: 40.h,
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
                                                  BorderRadius.circular(
                                                10.r,
                                              ),
                                            ),
                                            child: Center(
                                              child: GestureDetector(
                                                onTap: () {
                                                  _makePhoneCall(
                                                      widget.whatsapp);
                                                },
                                                child: Icon(
                                                  color: ColorManager.black,
                                                  Icons.phone,
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
