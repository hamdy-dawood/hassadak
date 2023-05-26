import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/error_network.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/constants/shimmer.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/details/view.dart';
import 'package:hassadak/pages/home/components/product_item.dart';

import 'cubit.dart';

class AllOffersView extends StatelessWidget {
  const AllOffersView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double itemHeight = (1.sh - kToolbarHeight * 1.5) / 2;
    final double itemWidth = 1.sw / 2;

    return Builder(builder: (context) {
      final cubit = OfferProductsCubit.get(context);
      cubit.getOfferProducts();
      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: 0.0,
          centerTitle: true,
          title: CustomText(
            text: "العروض المميزة",
            color: ColorManager.mainColor,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: RefreshIndicator(
          backgroundColor: ColorManager.secMainColor,
          color: Colors.white,
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 300));
            cubit.getOfferProducts();
          },
          child: SizedBox(
            width: 1.sw,
            height: 1.sh,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: BlocBuilder<OfferProductsCubit, OfferProductsStates>(
                builder: (context, state) {
                  if (state is OfferProductsLoadingState) {
                    return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.w,
                        crossAxisSpacing: 10.w,
                        childAspectRatio: (itemWidth / itemHeight),
                      ),
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return ContainerShimmer(
                          height: 200.h,
                          width: 0.5.sw,
                          margin: EdgeInsets.all(0.h),
                          padding: EdgeInsets.all(0.h),
                        );
                      },
                    );
                  } else if (state is OfferProductsFailedState) {
                    return Center(child: Text(state.msg));
                  } else if (state is NetworkErrorState) {
                    return ErrorNetwork(
                      press: () {
                        cubit.getOfferProducts();
                      },
                    );
                  } else {
                    return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.w,
                        crossAxisSpacing: 0.w,
                        childAspectRatio: (itemWidth / itemHeight),
                      ),
                      itemCount: cubit.allProducts!.data!.doc!.length,
                      itemBuilder: (context, index) {
                        final product = cubit.allProducts!.data!.doc![index];
                        double number = double.parse(
                            "${product.price! - (product.price! * (product.discountPerc! / 100))}");
                        String formatOldPrice = number.toStringAsFixed(2);
                        return InkWell(
                          onTap: () {
                            navigateTo(
                              page: DetailsView(
                                id: "${product.id}",
                                image: "${product.productUrl}",
                                userImage: "${product.userPhoto}",
                                productName: "${product.name}",
                                userName: "${product.uploaderName}",
                                desc: "${product.desc}",
                                phone: "${product.sellerPhone}",
                                isOffer:
                                    product.discountPerc == 0 ? false : true,
                                price: formatOldPrice,
                                oldPrice: "${product.price}",
                                ratingsAverage:
                                    (product.ratingsAverage)!.toInt(),
                                ratingsQuantity: (product.ratingsQuantity!),
                                favStatus: product.status!,
                                uploaderId: "${product.uploaderId}",
                              ),
                            );
                          },
                          child: ProductItem(
                            width: 0.44,
                            favIcon: SvgIcon(
                              icon: 'assets/icons/heart.svg',
                              color: ColorManager.white,
                              height: 18.h,
                            ),
                            favTap: () {},
                            isOffer: product.discountPerc == 0 ? false : true,
                            offer: "خصم ${product.discountPerc}%",
                            image: "${product.productUrl}",
                            title: "${product.name}",
                            userName: "${product.uploaderName}",
                            userImage: "${product.userPhoto}",
                            price: formatOldPrice,
                            oldPrice: "${product.price}",
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}
