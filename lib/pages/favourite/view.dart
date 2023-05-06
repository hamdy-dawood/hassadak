import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/favourite_item.dart';
import 'package:hassadak/constants/app_bar.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/shimmer.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/details/view.dart';

import 'cubit.dart';
import 'delete_fav/cubit.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AllFavouritesCubit()),
        BlocProvider(create: (context) => DeleteFavCubit()),
      ],
      child: Builder(builder: (context) {
        final favCubit = AllFavouritesCubit.get(context);
        final deleteFavCubit = DeleteFavCubit.get(context);
        favCubit.getAllFavourites();
        return RefreshIndicator(
          backgroundColor: ColorManager.secMainColor,
          color: Colors.white,
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            favCubit.getAllFavourites();
          },
          child: Scaffold(
            backgroundColor: ColorManager.white,
            appBar: customAppBar(text: "المفضلة"),
            body: SizedBox(
              width: 1.sw,
              height: 1.sh,
              child: StreamBuilder<AllFavouritesStates>(
                stream: AllFavouritesCubit.get(context).allFavouritesStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  final state = snapshot.data;
                  if (state is AllFavouritesLoadingStates ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return ContainerShimmer(
                            height: 150.h,
                            width: 0.5.sw,
                            margin: EdgeInsets.all(5.h),
                            padding: EdgeInsets.all(0.h),
                          );
                        });
                  } else if (state is AllFavouritesFailedStates) {
                    return Text(state.msg);
                  } else {
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      shrinkWrap: true,
                      itemCount: favCubit.allFavourites!.products.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 10.w,
                        );
                      },
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            navigateTo(
                              page: DetailsView(
                                id: favCubit.allFavourites!.products[index].id,
                                image: favCubit
                                    .allFavourites!.products[index].productUrl,
                                name: favCubit
                                    .allFavourites!.products[index].name,
                                desc: favCubit
                                    .allFavourites!.products[index].desc,
                                price:
                                    "${favCubit.allFavourites!.products[index].price}",
                                oldPrice:
                                    "${favCubit.allFavourites!.products[index].price - (favCubit.allFavourites!.products[index].price * 0.2)}",
                                ratingsAverage: (favCubit.allFavourites!
                                        .products[index].ratingsAverage)
                                    .toInt(),
                                ratingsQuantity: (favCubit.allFavourites!
                                    .products[index].ratingsQuantity),
                              ),
                            );
                          },
                          child: FavouriteItem(
                            offer: 'خصم 20%',
                            title: favCubit.allFavourites!.products[index].name,
                            image: favCubit
                                .allFavourites!.products[index].productUrl,
                            userName: 'محمد احمد',
                            userImage: 'assets/images/user.png',
                            price:
                                "${favCubit.allFavourites!.products[index].price}",
                            oldPrice:
                                "${favCubit.allFavourites!.products[index].price - (favCubit.allFavourites!.products[index].price * 0.2)}",
                            deleteTap: (context) async {
                              deleteFavCubit.deleteFav(
                                  id: favCubit
                                      .allFavourites!.products[index].id);
                              await Future.delayed(const Duration(seconds: 1));
                              favCubit.getAllFavourites();
                            },
                          ),
                        );
                      },
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
