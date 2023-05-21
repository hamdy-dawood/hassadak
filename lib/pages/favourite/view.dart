import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/error_network.dart';
import 'package:hassadak/constants/app_bar.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/shimmer.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/details/view.dart';

import 'components/favourite_item.dart';
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
              child: BlocBuilder<AllFavouritesCubit, AllFavouritesStates>(
                builder: (context, state) {
                  if (state is AllFavouritesLoadingStates) {
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
                    return Center(child: Text(state.msg));
                  } else if (state is NetworkErrorState) {
                    return ErrorNetwork(press: () {
                      favCubit.getAllFavourites();
                    });
                  } else {
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      shrinkWrap: true,
                      itemCount: favCubit.allFavourites!.products!.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 10.w,
                        );
                      },
                      itemBuilder: (context, index) {
                        final favItem =
                            favCubit.allFavourites!.products![index];
                        return InkWell(
                          onTap: () {
                            navigateTo(
                              page: DetailsView(
                                id: "${favItem.id}",
                                image: "${favItem.productUrl}",
                                userImage: UrlsStrings.userImageUrl,
                                productName: "${favItem.name}",
                                userName: "${favItem.uploaderName}",
                                desc: "${favItem.desc}",
                                phone: "${favItem.sellerPhone}",
                                isOffer:
                                    favItem.discountPerc == 0 ? false : true,
                                price: "${favItem.price}",
                                oldPrice:
                                    "${favItem.price! - (favItem.price! * (favItem.discountPerc! / 100))}",
                                ratingsAverage:
                                    (favItem.ratingsAverage)!.toInt(),
                                ratingsQuantity: favItem.ratingsQuantity!,
                                favStatus: true,
                              ),
                            );
                          },
                          child: FavouriteItem(
                            isOffer: favItem.discountPerc == 0 ? false : true,
                            offer: "خصم ${favItem.discountPerc}%",
                            title: "${favItem.name}",
                            image: "${favItem.productUrl}",
                            userName: "${favItem.uploaderName}",
                            userImage: UrlsStrings.userImageUrl,
                            price: "${favItem.price}",
                            oldPrice:
                                "${favItem.price! - (favItem.price! * 0.2)}",
                            deleteTap: (context) async {
                              deleteFavCubit.deleteFav(id: "${favItem.id}");
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
