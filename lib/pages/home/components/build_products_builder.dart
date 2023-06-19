import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/error_network.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/shimmer.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/details/view.dart';
import 'package:hassadak/pages/favourite/add_fav/cubit.dart';
import 'package:hassadak/pages/favourite/delete_fav/cubit.dart';
import 'package:hassadak/pages/home/all_products/cubit.dart';
import 'package:hassadak/pages/home/components/product_item.dart';

class BuildProductsBuilder extends StatelessWidget {
  const BuildProductsBuilder({
    Key? key,
    required this.allProductsCubit,
    required this.addFavCubit,
    required this.deleteFavCubit,
  }) : super(key: key);
  final AllProductsCubit allProductsCubit;
  final AddFavCubit addFavCubit;
  final DeleteFavCubit deleteFavCubit;

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
              double number = double.parse(
                  "${product.price! - (product.price! * (product.discountPerc! / 100))}");
              String formatOldPrice = number.toStringAsFixed(2);
              return BlocBuilder<AddFavCubit, AddFavStates>(
                builder: (context, state) {
                  final favStatus = addFavCubit.favStatusMap[index] ??
                      FavStatus(product.status!);
                  return InkWell(
                    onTap: () {
                      navigateTo(
                        page: DetailsView(
                          id: "${product.id}",
                          image: "${product.productUrl}",
                          productName: "${product.name}",
                          desc: "${product.desc}",
                          telephone: "${product.user!.telephone}",
                          whatsapp: "${product.user!.whatsapp}",
                          isOffer: product.discountPerc == 0 ? false : true,
                          price: formatOldPrice,
                          oldPrice: "${product.price}",
                          ratingsAverage: (product.ratingsAverage)!.toInt(),
                          ratingsQuantity: (product.ratingsQuantity!),
                          favStatus: favStatus.isLoved,
                          uploaderId: "${product.uploaderId}",
                          userName: "${product.uploaderName}",
                          userImage: "${product.userPhoto}",
                        ),
                      );
                    },
                    child: ProductItem(
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
                        if (product.status! == false) {
                          addFavCubit.addFav(id: product.id!);
                          addFavCubit.changeFavourite(index, product.status!);
                        } else {
                          // deleteFavCubit.deleteFav(id: product.id!);
                          addFavCubit.changeFavourite(index, product.status!);
                        }
                      },
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
            },
          );
        }
      },
    );
  }
}
