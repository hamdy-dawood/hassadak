import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/components/tap_search.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/shimmer.dart';
import 'package:hassadak/pages/favourite/add_fav/cubit.dart';
import 'package:hassadak/pages/home/offers/cubit.dart';

import 'all_products/cubit.dart';
import 'categories/cubit.dart';
import 'components/build_offers_header.dart';
import 'components/build_products_stream.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 5);
    tabController.addListener(() {
      _currentIndex = tabController.index;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final allProductsCubit = AllProductsCubit.get(context);
      final offersCubit = AllOffersCubit.get(context);
      final categoriesCubit = AllCategoriesCubit.get(context);
      final addFavCubit = AddFavCubit.get(context);

      offersCubit.getAllOffers();
      categoriesCubit.getAllCategories();

      return Scaffold(
        backgroundColor: ColorManager.white,
        body: SizedBox(
          width: 1.sw,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 5.h, bottom: 20.h),
                child: SvgIcon(
                  icon: "assets/icons/logo.svg",
                  color: ColorManager.green,
                  height: 60.h,
                ),
              ),
              const TapToSearch(),
              BuildOfferHeader(
                offersCubit: offersCubit,
                context: context,
              ),
              TabBar(
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
                          id: "?categoryId=${categoriesCubit.allCategories?.data.doc[_currentIndex].id}",
                        );
                      }
                      if (state is AllCategoriesLoadingStates ||
                          snapshot.connectionState == ConnectionState.waiting) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 20.w),
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
                          text: categoriesCubit
                              .allCategories?.data.doc[index].name,
                        );
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 270.h,
                child: TabBarView(
                  controller: tabController,
                  children: List.generate(
                    5,
                    (index) => BuildProductsStream(
                      allProductsCubit: allProductsCubit,
                      addFavCubit: addFavCubit,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
