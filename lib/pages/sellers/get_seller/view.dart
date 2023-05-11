import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/constants/shimmer.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/details/view.dart';
import 'package:hassadak/pages/home/components/product_item.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shimmer/shimmer.dart';

import 'cubit.dart';

class GetSellerView extends StatelessWidget {
  const GetSellerView({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetSellerCubit(),
      child: Builder(builder: (context) {
        final cubit = GetSellerCubit.get(context);
        cubit.getSeller(id: id);
        return Scaffold(
          backgroundColor: ColorManager.white,
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: SvgIcon(
                icon: "assets/icons/arrow.svg",
                height: 18.h,
                color: ColorManager.black,
              ),
            ),
          ),
          body: SizedBox(
            height: 1.sh,
            width: 1.sw,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: BlocBuilder<GetSellerCubit, GetSellerStates>(
                builder: (context, state) {
                  if (state is GetSellerLoadingState) {
                    return SizedBox(
                      height: 1.sh,
                      child: Shimmer.fromColors(
                        baseColor: ColorManager.shimmerBaseColor,
                        highlightColor: ColorManager.shimmerHighlightColor,
                        direction: ShimmerDirection.rtl,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 0.02.sh,
                              ),
                              CircleAvatar(
                                radius: 50.r,
                                backgroundColor: ColorManager.shimmerBaseColor,
                              ),
                              SizedBox(
                                height: 0.02.sh,
                              ),
                              Container(
                                height: 20.h,
                                width: 150.w,
                                color: ColorManager.shimmerBaseColor,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Container(
                                height: 20.h,
                                width: 300.w,
                                color: ColorManager.shimmerBaseColor,
                              ),
                              SizedBox(
                                height: 40.h,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  height: 20.h,
                                  width: 150.w,
                                  color: ColorManager.shimmerBaseColor,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  10,
                                  (index) => Container(
                                    margin: EdgeInsets.only(bottom: 5.h),
                                    height: 15.h,
                                    width: 300.w,
                                    color: ColorManager.shimmerBaseColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else if (state is GetSellerFailedState) {
                    return Text(state.msg);
                  } else {
                    return ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: CircleAvatar(
                            radius: 60.r,
                            backgroundColor: ColorManager.secMainColor,
                            child: ClipOval(
                              child: CachedNetworkImage(
                                fit: BoxFit.contain,
                                imageUrl: "${cubit.sellerResponse!.user.image}",
                                placeholder: (context, url) =>
                                    JumpingDotsProgressIndicator(
                                  fontSize: 20.h,
                                  color: ColorManager.secMainColor,
                                ),
                                errorWidget: (context, url, error) => Center(
                                  child:
                                      Image.asset("assets/images/no_image.png"),
                                ),
                              ),
                            ),
                          ),
                        ),
                        CustomText(
                          textAlign: TextAlign.center,
                          text: "${cubit.sellerResponse!.user.username}",
                          color: ColorManager.secMainColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 25.sp,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        CustomText(
                          textAlign: TextAlign.center,
                          text: "${cubit.sellerResponse!.user.email}",
                          color: ColorManager.secMainColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 20.sp,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomText(
                          text: "نبذة عني",
                          color: ColorManager.secMainColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 25.sp,
                        ),
                        SizedBox(
                          height: 0.01.sh,
                        ),
                        CustomText(
                          text:
                              "يعد اكسايت الغانم للالكترونيات أكبر موزع للالكترونيات في الكويت ويضم العديد من العلامات التجارية من بينها ما يفوق الـ٣٠٠ علامة تجارية عالمية. أما شركة صناعات الغانم التي يندرج تحتها اكسايت فهي واحدة من أكبر شركات القطاع الخاص في منطقة الخليج. وهي تمارس أنشطتها المتعددة في ٤٠ دولة وفي أكثر من ٣٠ مجال.",
                          color: ColorManager.navGrey,
                          fontWeight: FontWeight.normal,
                          fontSize: 20.sp,
                          maxLines: 5,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomText(
                          text: "تابعنا على",
                          color: ColorManager.secMainColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 25.sp,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: SvgPicture.asset(
                                "assets/icons/whatsapp.svg",
                                height: 50.h,
                              ),
                            ),
                            SizedBox(
                              width: 10.h,
                            ),
                            InkWell(
                              onTap: () {},
                              child: SvgPicture.asset(
                                "assets/icons/twitter.svg",
                                height: 50.h,
                              ),
                            ),
                            SizedBox(
                              width: 10.h,
                            ),
                            InkWell(
                              onTap: () {},
                              child: SvgPicture.asset(
                                "assets/icons/instagram.svg",
                                height: 50.h,
                              ),
                            ),
                            SizedBox(
                              width: 10.h,
                            ),
                            InkWell(
                              onTap: () {},
                              child: SvgPicture.asset(
                                "assets/icons/facebook.svg",
                                height: 50.h,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomText(
                          text: "المنتجات",
                          color: ColorManager.secMainColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 25.sp,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 270.h,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                cubit.sellerResponse!.getUserProduct.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  navigateTo(
                                    page: DetailsView(
                                      id: "${cubit.sellerResponse!.getUserProduct[index].id}",
                                      image:
                                          "${cubit.sellerResponse!.getUserProduct[index].productUrl}",
                                      userImage:
                                          "${cubit.sellerResponse!.user.image}",
                                      name:
                                          "${cubit.sellerResponse!.getUserProduct[index].name}",
                                      desc:
                                          "${cubit.sellerResponse!.getUserProduct[index].desc}",
                                      price:
                                          "${cubit.sellerResponse!.getUserProduct[index].price}",
                                      oldPrice:
                                          "${cubit.sellerResponse!.getUserProduct[index].price! - (cubit.sellerResponse!.getUserProduct[index].price! * (cubit.sellerResponse!.getUserProduct[index].discountPerc! / 100))}",
                                      ratingsAverage: cubit.sellerResponse!
                                          .getUserProduct[index].ratingsAverage!
                                          .toInt(),
                                      ratingsQuantity: cubit
                                          .sellerResponse!
                                          .getUserProduct[index]
                                          .ratingsQuantity!
                                          .toInt(),
                                    ),
                                  );
                                },
                                child: BlocBuilder<GetSellerCubit,
                                    GetSellerStates>(
                                  builder: (context, state) {
                                    if (state is GetSellerLoadingState) {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 3,
                                        itemBuilder: (context, index) {
                                          return ContainerShimmer(
                                            height: 100.h,
                                            width: 0.5.sw,
                                            margin:
                                                EdgeInsets.only(right: 10.w),
                                            padding: EdgeInsets.all(0.h),
                                          );
                                        },
                                      );
                                    } else if (state is GetSellerFailedState) {
                                      return Text(state.msg);
                                    } else {
                                      return ProductItem(
                                        favIcon: SvgIcon(
                                          icon: "assets/icons/heart.svg",
                                          color: ColorManager.white,
                                          height: 18.h,
                                        ),
                                        favTap: () {},
                                        offer:
                                            'خصم ${cubit.sellerResponse!.getUserProduct[index].discountPerc}%',
                                        image:
                                            "${cubit.sellerResponse!.getUserProduct[index].productUrl}",
                                        title:
                                            "${cubit.sellerResponse!.getUserProduct[index].name}",
                                        userName:
                                            "${cubit.sellerResponse!.user.username}",
                                        userImage:
                                            "${cubit.sellerResponse!.user.image}",
                                        price:
                                            "${cubit.sellerResponse!.getUserProduct[index].price}",
                                        oldPrice:
                                            "${cubit.sellerResponse!.getUserProduct[index].price! - (cubit.sellerResponse!.getUserProduct[index].price! * (cubit.sellerResponse!.getUserProduct[index].discountPerc! / 100))}",
                                      );
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}
