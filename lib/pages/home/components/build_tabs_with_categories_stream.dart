import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/shimmer.dart';
import 'package:hassadak/pages/home/all_products/cubit.dart';
import 'package:hassadak/pages/home/categories/cubit.dart';

class BuildTabsWithCategoriesStream extends StatelessWidget {
  const BuildTabsWithCategoriesStream({
    Key? key,
    required this.categoriesCubit,
    required this.allProductsCubit,
    required this.currentIndex,
    required this.tabController,
  }) : super(key: key);

  final AllCategoriesCubit categoriesCubit;
  final AllProductsCubit allProductsCubit;
  final int currentIndex;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      controller: tabController,
      labelColor: ColorManager.secMainColor,
      labelStyle: GoogleFonts.almarai(
        textStyle: TextStyle(
          color: ColorManager.secMainColor,
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
        ),
      ),
      unselectedLabelColor: ColorManager.grey,
      unselectedLabelStyle: GoogleFonts.almarai(
        textStyle: TextStyle(
          color: ColorManager.secMainColor,
          fontSize: 15.sp,
        ),
      ),
      indicatorColor: Colors.transparent,
      tabs: List.generate(
        5,
        (index) => StreamBuilder<AllCategoriesStates>(
          stream: AllCategoriesCubit.get(context).allCategoriesStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            final state = snapshot.data;
            if (state is AllCategoriesSuccessStates) {
              allProductsCubit.getAllProducts(
                id: "?categoryId=${categoriesCubit.allCategories?.data.doc[currentIndex].id}",
              );
            }
            if (state is AllCategoriesLoadingStates ||
                snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.w),
                child: SizedBox(
                  height: 20.h,
                  child: ListView.separated(
                    itemCount: 5,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => SizedBox(
                      width: 10.w,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ContainerShimmer(
                        height: 20.h,
                        width: 0.3.sw,
                        margin: EdgeInsets.all(0.h),
                        padding: EdgeInsets.all(0.h),
                        radius: 5.r,
                      );
                    },
                  ),
                ),
              );
            } else if (state is AllCategoriesFailedStates) {
              return Text(state.msg);
            } else {
              return Tab(
                text: categoriesCubit.allCategories?.data.doc[index].name,
              );
            }
          },
        ),
      ),
    );
  }
}
