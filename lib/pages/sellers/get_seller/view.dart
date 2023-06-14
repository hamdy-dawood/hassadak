import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hassadak/components/build_cache_image.dart';
import 'package:hassadak/components/error_network.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/constants/shimmer.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/details/view.dart';
import 'package:hassadak/pages/favourite/add_fav/cubit.dart';
import 'package:hassadak/pages/home/components/product_item.dart';
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
        final addFavCubit = AddFavCubit.get(context);

        cubit.getSeller(id: id);
        return RefreshIndicator(
          backgroundColor: ColorManager.secMainColor,
          color: Colors.white,
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 500));
            cubit.getSeller(id: id);
          },
          child: Scaffold(
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
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: BuildCacheCircleImage(
                            imageUrl: UrlsStrings.userImageUrl,
                            height: 100.h,
                            loadingHeight: 50.h,
                          ),
                        ),
                        CustomText(
                          textAlign: TextAlign.center,
                          text: "لا يوجد ",
                          color: ColorManager.secMainColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 25.sp,
                        ),
                      ],
                    );
                  } else if (state is NetworkErrorState) {
                    return ErrorNetwork(
                      press: () {
                        cubit.getSeller(id: id);
                      },
                    );
                  } else {
                    return ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  child: BuildCacheCircleImage(
                                    imageUrl:
                                        "${cubit.sellerResponse!.user!.userPhoto}",
                                    height: 100.h,
                                    loadingHeight: 50.h,
                                  ),
                                ),
                              ),
                              Center(
                                child: CustomText(
                                  textAlign: TextAlign.center,
                                  text:
                                      "${cubit.sellerResponse!.user!.firstName} ${cubit.sellerResponse!.user!.lastName}",
                                  color: ColorManager.secMainColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 25.sp,
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Center(
                                child: CustomText(
                                  textAlign: TextAlign.center,
                                  text: "${cubit.sellerResponse!.user!.email}",
                                  color: ColorManager.secMainColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20.sp,
                                ),
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
                                    "${cubit.sellerResponse!.user!.description}",
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
                                    onTap: () {
                                      cubit.pressLaunch(Uri.parse(
                                          "https://api.whatsapp.com/send/?phone=%2B2${cubit.sellerResponse!.user!.telephone}"));
                                    },
                                    child: SvgPicture.asset(
                                      "assets/icons/whatsapp.svg",
                                      height: 50.h,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.h,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      cubit.pressLaunch(Uri.parse(
                                          "https://${cubit.sellerResponse!.user!.twitterUrl}"));
                                    },
                                    child: SvgPicture.asset(
                                      "assets/icons/twitter.svg",
                                      height: 50.h,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.h,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      cubit.pressLaunch(Uri.parse(
                                          "https://${cubit.sellerResponse!.user!.instaUrl}"));
                                    },
                                    child: SvgPicture.asset(
                                      "assets/icons/instagram.svg",
                                      height: 50.h,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.h,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      cubit.pressLaunch(Uri.parse(
                                          "https://${cubit.sellerResponse!.user!.facebookUrl}"));
                                    },
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
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 270.h,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                cubit.sellerResponse!.getUserProduct!.length,
                            itemBuilder: (context, index) {
                              final uerProduct =
                                  cubit.sellerResponse!.getUserProduct![index];
                              double number = double.parse(
                                  "${uerProduct.price! - (uerProduct.price! * (uerProduct.discountPerc! / 100))}");
                              String formatOldPrice = number.toStringAsFixed(2);
                              return InkWell(
                                onTap: () {
                                  navigateTo(
                                    page: DetailsView(
                                      id: "${uerProduct.id}",
                                      image: "${uerProduct.productUrl}",
                                      userImage:
                                          "${cubit.sellerResponse!.user!.userPhoto}",
                                      productName: "${uerProduct.name}",
                                      userName:
                                          "${cubit.sellerResponse!.user!.username}",
                                      desc: "${uerProduct.desc}",
                                      phone: "${uerProduct.sellerWhatsapp}",
                                      isOffer: cubit
                                                  .sellerResponse!
                                                  .getUserProduct![index]
                                                  .discountPerc ==
                                              0
                                          ? false
                                          : true,
                                      price: formatOldPrice,
                                      oldPrice: "${uerProduct.price}",
                                      ratingsAverage:
                                          uerProduct.ratingsAverage!.toInt(),
                                      ratingsQuantity:
                                          uerProduct.ratingsQuantity!.toInt(),
                                      favStatus: false,
                                      uploaderId: "${uerProduct.uploaderId}",
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
                                      return BlocBuilder<AddFavCubit,
                                          AddFavStates>(
                                        builder: (context, state) {
                                          final favStatus =
                                              addFavCubit.favStatusMap[index] ??
                                                  FavStatus(false);
                                          return ProductItem(
                                            favIcon: SvgIcon(
                                              icon: favStatus.isLoved
                                                  ? "assets/icons/fill_heart.svg"
                                                  : "assets/icons/heart.svg",
                                              color: favStatus.isLoved
                                                  ? ColorManager.green
                                                  : ColorManager.white,
                                              height: 18.h,
                                            ),
                                            favTap: () {
                                              addFavCubit.addFav(
                                                  id: uerProduct.id!);
                                              addFavCubit.changeFavourite(
                                                  index, true);
                                            },
                                            isOffer:
                                                uerProduct.discountPerc == 0
                                                    ? false
                                                    : true,
                                            offer:
                                                "خصم ${uerProduct.discountPerc}%",
                                            image: "${uerProduct.productUrl}",
                                            title: "${uerProduct.name}",
                                            userName:
                                                "${uerProduct.uploaderName}",
                                            userImage:
                                                "${cubit.sellerResponse!.user!.userPhoto}",
                                            price: formatOldPrice,
                                            oldPrice: "${uerProduct.price}",
                                          );
                                        },
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
