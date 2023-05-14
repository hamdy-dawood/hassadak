import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/error_network.dart';
import 'package:hassadak/constants/app_bar.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/constants/shimmer.dart';
import 'package:hassadak/core/snack_and_navigate.dart';

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
        cubit.getAllSellers();
        return Scaffold(
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
                } else if (state is SellersNotHaveAccessState) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: CustomText(
                        text: "ليس لديك الصلاحية في رؤية الشركات",
                        color: ColorManager.mainColor,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else if (state is AllSellersFailedState) {
                  return Text(state.msg);
                } else if (state is NetworkErrorState) {
                  return const ErrorNetwork();
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: cubit.allSellers!.results,
                    itemBuilder: (context, index) {
                      return CustomListTile(
                        onTap: () {
                          navigateTo(
                            page: GetSellerView(
                              id: "${cubit.allSellers!.data!.doc![index].id}",
                            ),
                          );
                        },
                        name: "${cubit.allSellers!.data!.doc![index].username}",
                        image: "${cubit.allSellers!.data!.doc![index].image}",
                        likes:
                            cubit.allSellers!.data!.doc![index].likes!.length,
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
