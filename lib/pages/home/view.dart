import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hassadak/components/product_item.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/components/tap_search.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/constants/shimmer.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/details/view.dart';
import 'package:hassadak/pages/home/offers/cubit.dart';
import 'package:hassadak/pages/login/cubit.dart';

import 'all_products/cubit.dart';
import 'categories/cubit.dart';

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
    tabController = TabController(vsync: this, length: 4);
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AllProductsCubit(),
        ),
        BlocProvider(
          create: (context) => AllOffersCubit(),
        ),
        BlocProvider(
          create: (context) => AllCategoriesCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
      ],
      child: Builder(builder: (context) {
        final allProductsCubit = AllProductsCubit.get(context);
        final offersCubit = AllOffersCubit.get(context);
        final categoriesCubit = AllCategoriesCubit.get(context);
        offersCubit.getAllOffers();
        categoriesCubit.getAllCategories();

        return Scaffold(
          backgroundColor: ColorManager.white,
          body: SizedBox(
            width: 1.sw,
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15.h, bottom: 20.h),
                  child: SvgIcon(
                    icon: "assets/icons/logo.svg",
                    color: ColorManager.green,
                    height: 80.h,
                  ),
                ),
                const TapToSearch(),
                BlocBuilder<AllOffersCubit, AllOffersStates>(
                  builder: (context, state) {
                    if (state is AllOffersLoadingStates) {
                      return Padding(
                        padding: EdgeInsets.only(top: 25.h),
                        child: SizedBox(
                          height: 120.h,
                          child: ListView.separated(
                              itemCount: 2,
                              shrinkWrap: true,
                              separatorBuilder: (context, index) => SizedBox(
                                    width: 10.w,
                                  ),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return ContainerShimmer(
                                  height: 100.h,
                                  width: 0.8.sw,
                                );
                              }),
                        ),
                      );
                    } else if (state is AllOffersFailedStates) {
                      return Text(state.msg);
                    } else {
                      return SizedBox(
                        height: 150.h,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(
                            width: 10.w,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: offersCubit.allOffers!.data.doc.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(
                                top: 25.h,
                                bottom: 10.h,
                                right: 10.w,
                              ),
                              padding: EdgeInsets.all(12.h),
                              height: 150.h,
                              width: 0.8.sw,
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.h),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        CustomText(
                                          text: offersCubit
                                              .allOffers!.data.doc[index].name,
                                          color: ColorManager.white,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        CustomText(
                                          text: offersCubit
                                              .allOffers!.data.doc[index].desc,
                                          color: ColorManager.white,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
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
                    4,
                    (index) => StreamBuilder<AllCategoriesStates>(
                      stream:
                          AllCategoriesCubit.get(context).allCategoriesStream,
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
                            snapshot.connectionState ==
                                ConnectionState.waiting) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 20.w),
                            child: SizedBox(
                              height: 20.h,
                              child: ListView.separated(
                                itemCount: 2,
                                shrinkWrap: true,
                                separatorBuilder: (context, index) => SizedBox(
                                  width: 10.w,
                                ),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return ContainerShimmer(
                                    height: 20.h,
                                    width: 1.sw,
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
                  height: 250.h,
                  child: TabBarView(
                    controller: tabController,
                    children: List.generate(
                      4,
                      (index) => StreamBuilder<AllProductsStates>(
                        stream: AllProductsCubit.get(context).allProductsStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          final state = snapshot.data;
                          if (state is AllProductsLoadingStates ||
                              snapshot.connectionState ==
                                  ConnectionState.waiting) {
                            return ListView.separated(
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  width: 10.w,
                                );
                              },
                              itemBuilder: (context, index) {
                                return ContainerShimmer(
                                  height: 100.h,
                                  width: 0.5.sw,
                                );
                              },
                            );
                          } else if (state is AllProductsFailedStates) {
                            return Text(state.msg);
                          } else {
                            return ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  allProductsCubit.allProducts!.data.doc.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    navigateTo(
                                      page: DetailsView(
                                        image: allProductsCubit.allProducts!
                                            .data.doc[index].productUrl,
                                        name: allProductsCubit
                                            .allProducts!.data.doc[index].name,
                                        desc: allProductsCubit
                                            .allProducts!.data.doc[index].desc,
                                        price:
                                            "${allProductsCubit.allProducts!.data.doc[index].price}",
                                        oldPrice:
                                            "${allProductsCubit.allProducts!.data.doc[index].price - (allProductsCubit.allProducts!.data.doc[index].price * 0.2)}",
                                        rating: (allProductsCubit.allProducts!
                                                .data.doc[index].ratingsAverage)
                                            .toInt(),
                                      ),
                                    );
                                  },
                                  child: ProductItem(
                                    offer: 'خصم 20%',
                                    image: allProductsCubit.allProducts!.data
                                        .doc[index].productUrl,
                                    title: allProductsCubit
                                        .allProducts!.data.doc[index].name,
                                    userName: 'محمد احمد',
                                    userImage: 'assets/images/user.png',
                                    price:
                                        "${allProductsCubit.allProducts!.data.doc[index].price}",
                                    oldPrice:
                                        "${allProductsCubit.allProducts!.data.doc[index].price - (allProductsCubit.allProducts!.data.doc[index].price * 0.2)}",
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                width: 10.w,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
