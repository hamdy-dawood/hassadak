import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/shimmer.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/details/view.dart';
import 'package:hassadak/pages/favourite/add_fav/cubit.dart';
import 'package:hassadak/pages/home/all_products/cubit.dart';
import 'package:hassadak/pages/home/components/product_item.dart';

class BuildProductsStream extends StatelessWidget {
  const BuildProductsStream(
      {Key? key, required this.allProductsCubit, required this.addFavCubit})
      : super(key: key);
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
        if (state is AllProductsLoadingStates ||
            snapshot.connectionState == ConnectionState.waiting) {
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
        } else if (state is AllProductsFailedStates) {
          return Text(state.msg);
        } else {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: allProductsCubit.allProducts!.data.doc.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  navigateTo(
                    page: DetailsView(
                      image: allProductsCubit
                          .allProducts!.data.doc[index].productUrl,
                      name: allProductsCubit.allProducts!.data.doc[index].name,
                      desc: allProductsCubit.allProducts!.data.doc[index].desc,
                      price:
                          "${allProductsCubit.allProducts!.data.doc[index].price}",
                      oldPrice:
                          "${allProductsCubit.allProducts!.data.doc[index].price - (allProductsCubit.allProducts!.data.doc[index].price * 0.2)}",
                      rating: (allProductsCubit
                              .allProducts!.data.doc[index].ratingsAverage)
                          .toInt(),
                    ),
                  );
                },
                child: BlocBuilder<AddFavCubit, AddFavStates>(
                  builder: (context, state) {
                    return ProductItem(
                      favIcon: SvgIcon(
                        icon: allProductsCubit.isLoved
                            ? "assets/icons/fill_heart.svg"
                            : "assets/icons/heart.svg",
                        color: allProductsCubit.isLoved
                            ? ColorManager.red
                            : ColorManager.white,
                        height: 18.h,
                      ),
                      favTap: () {
                        addFavCubit.addFav(
                            id: allProductsCubit
                                .allProducts!.data.doc[index].id);
                        allProductsCubit.changeFavourite();
                      },
                      offer: 'خصم 20%',
                      image: allProductsCubit
                          .allProducts!.data.doc[index].productUrl,
                      title: allProductsCubit.allProducts!.data.doc[index].name,
                      userName: 'محمد احمد',
                      userImage: 'assets/images/user.png',
                      price:
                          "${allProductsCubit.allProducts!.data.doc[index].price}",
                      oldPrice:
                          "${allProductsCubit.allProducts!.data.doc[index].price - (allProductsCubit.allProducts!.data.doc[index].price * 0.2)}",
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
