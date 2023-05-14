import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/shimmer.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/details/view.dart';
import 'package:hassadak/pages/favourite/add_fav/cubit.dart';
import 'package:hassadak/pages/home/all_products/cubit.dart';
import 'package:hassadak/pages/home/components/product_item.dart';

class BuildProductsStream extends StatelessWidget {
  const BuildProductsStream({
    Key? key,
    required this.allProductsCubit,
    required this.addFavCubit,
  }) : super(key: key);
  final AllProductsCubit allProductsCubit;
  final AddFavCubit addFavCubit;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AllProductsStates>(
      stream: AllProductsCubit.get(context).allProductsStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        final state = snapshot.data;
        if ((state is AllProductsLoadingState ||
            snapshot.connectionState == ConnectionState.waiting)) {
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
        } else {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: allProductsCubit.allProducts!.data!.doc!.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  navigateTo(
                    page: DetailsView(
                      id: "${allProductsCubit.allProducts!.data!.doc![index].id}",
                      image:
                          "${allProductsCubit.allProducts!.data!.doc![index].productUrl}",
                      userImage: UrlsStrings.userImageUrl,
                      productName:
                          "${allProductsCubit.allProducts!.data!.doc![index].name}",
                      userName:"${allProductsCubit.allProducts!.data!.doc![index].uploaderName}",
                      desc:
                          "${allProductsCubit.allProducts!.data!.doc![index].desc}",
                      price:
                          "${allProductsCubit.allProducts!.data!.doc![index].price}",
                      oldPrice:
                          "${allProductsCubit.allProducts!.data!.doc![index].price! - (allProductsCubit.allProducts!.data!.doc![index].price! * 0.2)}",
                      ratingsAverage: (allProductsCubit
                              .allProducts!.data!.doc![index].ratingsAverage)!
                          .toInt(),
                      ratingsQuantity: (allProductsCubit
                          .allProducts!.data!.doc![index].ratingsQuantity!),
                    ),
                  );
                },
                child: BlocBuilder<AddFavCubit, AddFavStates>(
                  builder: (context, state) {
                    // addFavCubit.isLoved =  allProductsCubit.allProducts!.data.doc[index].status;
                    return ProductItem(
                      favIcon: SvgIcon(
                        icon: allProductsCubit
                                .allProducts!.data!.doc![index].status!
                            ? "assets/icons/fill_heart.svg"
                            : "assets/icons/heart.svg",
                        color: allProductsCubit
                                .allProducts!.data!.doc![index].status!
                            ? ColorManager.green
                            : ColorManager.white,
                        height: 18.h,
                      ),
                      favTap: () {
                        addFavCubit.addFav(
                            id: allProductsCubit
                                .allProducts!.data!.doc![index].id!);
                      },
                      offer: 'خصم 20%',
                      image:
                          "${allProductsCubit.allProducts!.data!.doc![index].productUrl}",
                      title:
                          "${allProductsCubit.allProducts!.data!.doc![index].name}",
                      userName:"${allProductsCubit.allProducts!.data!.doc![index].uploaderName}",
                      userImage: 'assets/images/user.png',
                      price:
                          "${allProductsCubit.allProducts!.data!.doc![index].price}",
                      oldPrice:
                          "${allProductsCubit.allProducts!.data!.doc![index].price! - (allProductsCubit.allProducts!.data!.doc![index].price! * 0.2)}",
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
