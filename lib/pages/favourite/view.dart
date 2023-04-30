import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/favourite_item.dart';
import 'package:hassadak/constants/app_bar.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/shimmer.dart';

import 'cubit.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllFavouritesCubit(),
      child: Builder(builder: (context) {
        final cubit = AllFavouritesCubit.get(context);
        cubit.getAllFavourites();
        return Scaffold(
          backgroundColor: ColorManager.white,
          appBar: customAppBar(text: "المفضلة"),
          body: SizedBox(
            width: double.infinity,
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
                    itemCount: cubit.allFavourites!.products.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10.w,
                      );
                    },
                    itemBuilder: (context, index) {
                      return FavouriteItem(
                        offer: 'خصم 20%',
                        title: cubit.allFavourites!.products[index].name,
                        image: cubit.allFavourites!.products[index].productUrl,
                        userName: 'محمد احمد',
                        userImage: 'assets/images/user.png',
                        price: "${cubit.allFavourites!.products[index].price}",
                        oldPrice:
                            "${cubit.allFavourites!.products[index].price - (cubit.allFavourites!.products[index].price * 0.2)}",
                      );
                    },
                  );
                }
              },
            ),
          ),
        );
      }),
    );
  }
}
