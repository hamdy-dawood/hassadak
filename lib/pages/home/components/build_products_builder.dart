import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/error_network.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/shimmer.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/details/view.dart';
import 'package:hassadak/pages/favourite/add_fav/cubit.dart';
import 'package:hassadak/pages/home/all_products/cubit.dart';
import 'package:hassadak/pages/home/components/product_item.dart';

class BuildProductsBuilder extends StatelessWidget {
  const BuildProductsBuilder({
    Key? key,
    required this.allProductsCubit,
    required this.addFavCubit,
  }) : super(key: key);
  final AllProductsCubit allProductsCubit;
  final AddFavCubit addFavCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllProductsCubit, AllProductsStates>(
      builder: (context, state) {
        if (state is AllProductsLoadingState) {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return ContainerShimmer(
                height: 100.h,
                width: 0.5.sw,
                margin: EdgeInsets.only(right: 10.w),
                padding: EdgeInsets.all(0.h),
              );
            },
          );
        } else if (state is AllProductsFailedState) {
          return Text(state.msg);
        } else if (state is NetworkErrorState) {
          return ErrorNetwork(reloadButton: false, press: () {});
        } else {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: allProductsCubit.allProducts!.data!.doc!.length,
            itemBuilder: (context, index) {
              final product = allProductsCubit.allProducts!.data!.doc![index];
              return InkWell(
                onTap: () {
                  navigateTo(
                    page: DetailsView(
                      id: "${product.id}",
                      image: "${product.productUrl}",
                      userImage: UrlsStrings.userImageUrl,
                      productName: "${product.name}",
                      userName: "${product.uploaderName}",
                      desc: "${product.desc}",
                      phone: "${product.sellerPhone}",
                      isOffer: product.discountPerc == 0 ? false : true,
                      price: "${product.price}",
                      oldPrice:
                          "${product.price! - (product.price! * (product.discountPerc! / 100))}",
                      ratingsAverage: (product.ratingsAverage)!.toInt(),
                      ratingsQuantity: (product.ratingsQuantity!),
                      favStatus: product.status!,
                    ),
                  );
                },
                child: BlocBuilder<AddFavCubit, AddFavStates>(
                  builder: (context, state) {
                    final favStatus = addFavCubit.favStatusMap[index] ??
                        FavStatus(product.status!);
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
                        addFavCubit.addFav(id: product.id!);
                        addFavCubit.changeFavourite(index);
                      },
                      isOffer: product.discountPerc == 0 ? false : true,
                      offer: "خصم ${product.discountPerc}%",
                      image: "${product.productUrl}",
                      title: "${product.name}",
                      userName: "${product.uploaderName}",
                      userImage: 'assets/images/user.png',
                      price: "${product.price}",
                      oldPrice:
                          "${product.price! - (product.price! * (product.discountPerc! / 100))}",
                    );
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}