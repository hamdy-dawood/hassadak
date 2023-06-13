import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/components/tap_search.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/constants/shimmer.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/bottom_nav_bar/view.dart';
import 'package:hassadak/pages/favourite/add_fav/cubit.dart';
import 'package:hassadak/pages/favourite/delete_fav/cubit.dart';

import '../offers/view.dart';
import 'all_products/cubit.dart';
import 'categories/cubit.dart';
import 'components/build_products_builder.dart';
import 'offer_header/cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  TabController? tabController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 0);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await AllCategoriesCubit.get(context).getAllCategories();
      setState(() {
        tabController = TabController(
            vsync: this, length: AllCategoriesCubit.get(context).length!);
      });
      tabController!.addListener(() {
        currentIndex = tabController!.index;
      });
    });
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final allProductsCubit = AllProductsCubit.get(context);
      final offersCubit = AllOffersCubit.get(context);
      final categoriesCubit = AllCategoriesCubit.get(context);
      final addFavCubit = AddFavCubit.get(context);
      final deleteFavCubit = DeleteFavCubit.get(context);
      offersCubit.getAllOffers();

      return RefreshIndicator(
        backgroundColor: ColorManager.secMainColor,
        color: Colors.white,
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 500));
          navigateTo(page: const NavBarView());
        },
        child: Scaffold(
          backgroundColor: ColorManager.white,
          body: SizedBox(
            width: 1.sw,
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 5.h, bottom: 10.h),
                  child: SvgIcon(
                    icon: "assets/icons/logo.svg",
                    height: 80.h,
                    color: ColorManager.green,
                  ),
                ),
                const TapToSearch(),
                GestureDetector(
                  onTap: () {
                    navigateTo(page: const AllOffersView());
                  },
                  child: Container(
                    height: 130.h,
                    width: 0.90.sw,
                    margin: EdgeInsets.all(16.h),
                    padding: EdgeInsets.all(12.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          ColorManager.secMainColor,
                          ColorManager.lightMainColor,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Image.asset(
                            "assets/images/offer.png",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomText(
                                text: "BLACK FRIDAY",
                                color: ColorManager.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              CustomText(
                                text: "30% off for all items",
                                color: ColorManager.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                BlocBuilder<AllCategoriesCubit, AllCategoriesStates>(
                  builder: (context, state) {
                    if (state is AllCategoriesLoadingStates &&
                        categoriesCubit.length == null) {
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
                    }
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
                        tabController!.length,
                        (index) => BlocBuilder<AllCategoriesCubit,
                            AllCategoriesStates>(
                          builder: (context, state) {
                            if (state is AllCategoriesFailedStates) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 5.h),
                                child: CustomText(
                                  text: "فشل",
                                  color: ColorManager.mainColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                              );
                            } else if (state is AllCategoriesSuccessStates) {
                              allProductsCubit.getAllProducts(
                                id: "?categoryId=${categoriesCubit.allCategories?.data.doc[currentIndex].id}",
                              );
                            }
                            return Tab(
                              text: categoriesCubit
                                  .allCategories?.data.doc[index].name,
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 270.h,
                  child: TabBarView(
                    controller: tabController,
                    children: List.generate(
                      tabController!.length,
                      (index) => BuildProductsBuilder(
                        allProductsCubit: allProductsCubit,
                        addFavCubit: addFavCubit,
                        deleteFavCubit: deleteFavCubit,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
