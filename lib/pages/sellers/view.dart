import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/error_network.dart';
import 'package:hassadak/constants/app_bar.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/shimmer.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/like_seller/cubit.dart';
import 'package:hassadak/pages/like_seller/states.dart';

import 'components/company_list_item.dart';
import 'cubit.dart';
import 'get_seller/view.dart';

class SellersView extends StatelessWidget {
  const SellersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllSellersCubit(),
      child: Builder(builder: (context) {
        final cubit = AllSellersCubit.get(context);
        final likeSellerCubit = LikeSellerCubit.get(context);
        cubit.getAllSellers();

        return RefreshIndicator(
          backgroundColor: ColorManager.secMainColor,
          color: Colors.white,
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 500));
            cubit.getAllSellers();
          },
          child: Scaffold(
            backgroundColor: ColorManager.white,
            appBar: customAppBar(text: "الشركات"),
            body: SizedBox(
              height: 1.sh,
              width: 1.sw,
              child: BlocBuilder<AllSellersCubit, AllSellersStates>(
                builder: (context, state) {
                  if (state is AllSellersLoadingState) {
                    return ListView.separated(
                        shrinkWrap: true,
                        itemCount: 7,
                        separatorBuilder: (context, index) => SizedBox(
                              height: 10.h,
                            ),
                        itemBuilder: (context, index) {
                          return const ListTileShimmer();
                        });
                  } else if (state is AllSellersFailedState) {
                    return Center(child: Text(state.msg));
                  } else if (state is NetworkErrorState) {
                    return ErrorNetwork(
                      press: () {
                        cubit.getAllSellers();
                      },
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: cubit.allSellers!.results,
                      itemBuilder: (context, index) {
                        return BlocBuilder<LikeSellerCubit, LikeSellerStates>(
                          builder: (context, state) {
                            return CustomListTile(
                              onTap: () {
                                navigateTo(
                                  page: GetSellerView(
                                    id: "${cubit.allSellers!.data!.doc![index].id}",
                                  ),
                                );
                              },
                              name:
                                  "${cubit.allSellers!.data!.doc![index].firstName} ${cubit.allSellers!.data!.doc![index].lastName}",
                              userImage:
                                  "${cubit.allSellers!.data!.doc![index].userPhoto}",
                              likes: cubit
                                  .allSellers!.data!.doc![index].likes!.length,
                              tapLikeSeller: () {
                                likeSellerCubit.likeSeller(
                                    id: "${cubit.allSellers!.data!.doc![index].id}");
                                Future.delayed(
                                    const Duration(milliseconds: 500));
                                cubit.getAllSellers();
                              },
                            );
                          },
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
