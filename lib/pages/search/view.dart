import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hassadak/components/custom_elevated.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/constants/shimmer.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/details/view.dart';
import 'package:hassadak/pages/home/all_products/cubit.dart';
import 'package:hassadak/pages/home/components/product_item.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    final priceController = TextEditingController();
    final focusNode = FocusNode();
    final double itemHeight = (1.sh - kToolbarHeight * 1.5) / 2;
    final double itemWidth = 1.sw / 2;
    return BlocProvider(
      create: (context) => AllProductsCubit(),
      child: Builder(builder: (context) {
        final allProductsCubit = AllProductsCubit.get(context);
        allProductsCubit.getAllProducts();
        return Scaffold(
          backgroundColor: ColorManager.white,
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: SvgIcon(
                icon: "assets/icons/arrow.svg",
                height: 18.h,
                color: ColorManager.black,
              ),
            ),
            title: CustomText(
              text: "البحث",
              color: ColorManager.mainColor,
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          body: RefreshIndicator(
            backgroundColor: ColorManager.secMainColor,
            color: Colors.white,
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
              allProductsCubit.getAllProducts();
            },
            child: SizedBox(
              height: 1.sh,
              width: 1.sw,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            child: Container(
                              height: 45.h,
                              decoration: BoxDecoration(
                                color: ColorManager.lightGrey,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Center(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 5.h, right: 5.h),
                                  child: TextFormField(
                                    focusNode: focusNode,
                                    onFieldSubmitted: (_) {
                                      if (searchController.text == "") {
                                        focusNode.unfocus();
                                      } else {
                                        allProductsCubit.getAllProducts(
                                          id: "/search/${searchController.text}",
                                        );
                                      }
                                    },
                                    controller: searchController,
                                    style: GoogleFonts.almarai(
                                      textStyle: TextStyle(
                                        color: ColorManager.black,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: " بحث",
                                      hintStyle: GoogleFonts.almarai(
                                        textStyle: TextStyle(
                                          color: ColorManager.grey,
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                      prefixIcon: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.h),
                                        child: SvgIcon(
                                          icon: "assets/icons/search.svg",
                                          color: ColorManager.black,
                                          height: 22.h,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 0.03.sw,
                        ),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15.r),
                                  topLeft: Radius.circular(15.r),
                                ),
                              ),
                              builder: (context) => Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: SizedBox(
                                  width: 1.sw,
                                  child: Padding(
                                    padding: EdgeInsets.all(30.h),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            CustomElevated(
                                              text: "تم",
                                              borderRadius: 12.r,
                                              btnColor:
                                                  ColorManager.secMainColor,
                                              wSize: 45.h,
                                              hSize: 45.h,
                                              press: () {
                                                Navigator.pop(context);
                                                allProductsCubit.getAllProducts(
                                                    id: "?price[gte]=${priceController.text}");
                                                searchController.clear();
                                              },
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 45.h,
                                                decoration: BoxDecoration(
                                                  color: ColorManager.lightGrey,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.r),
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5.h, right: 5.h),
                                                    child: TextFormField(
                                                      controller:
                                                          priceController,
                                                      style:
                                                          GoogleFonts.almarai(
                                                        textStyle: TextStyle(
                                                          color: ColorManager
                                                              .black,
                                                          fontSize: 18.sp,
                                                        ),
                                                      ),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: "اكتب السعر",
                                                        hintStyle:
                                                            GoogleFonts.almarai(
                                                          textStyle: TextStyle(
                                                            color: ColorManager
                                                                .grey,
                                                            fontSize: 20.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        CustomElevated(
                                          text: 'ترتيب حسب الاقل سعر',
                                          borderRadius: 12.r,
                                          btnColor: ColorManager.secMainColor,
                                          wSize: 1.sw,
                                          press: () {
                                            Navigator.pop(context);
                                            allProductsCubit.getAllProducts(
                                                id: "?sort=price");
                                          },
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        CustomElevated(
                                          text: 'ترتيب حسب الأعلي سعر',
                                          borderRadius: 12.r,
                                          btnColor: ColorManager.secMainColor,
                                          wSize: 1.sw,
                                          press: () {
                                            Navigator.pop(context);
                                            allProductsCubit.getAllProducts(
                                                id: "?sort=-price");
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 45.h,
                            width: 0.15.sw,
                            decoration: BoxDecoration(
                              color: ColorManager.lightGrey,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12.h),
                              child: SvgIcon(
                                icon: "assets/icons/rectangle.svg",
                                color: ColorManager.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    StreamBuilder<AllProductsStates>(
                      stream: AllProductsCubit.get(context).allProductsStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        final state = snapshot.data;
                        if (state is AllProductsLoadingState ||
                            snapshot.connectionState ==
                                ConnectionState.waiting) {
                          return Expanded(
                            child: GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10.w,
                                crossAxisSpacing: 10.w,
                                childAspectRatio: (itemWidth / itemHeight),
                              ),
                              itemCount: 20,
                              itemBuilder: (context, index) {
                                return ContainerShimmer(
                                  height: 200.h,
                                  width: 0.5.sw,
                                  margin: EdgeInsets.all(0.h),
                                  padding: EdgeInsets.all(0.h),
                                );
                              },
                            ),
                          );
                        } else if (state is AllProductsFailedState) {
                          return Text(state.msg);
                        } else {
                          return Expanded(
                            child: GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 5.w,
                                mainAxisSpacing: 10.w,
                                childAspectRatio: (itemWidth / itemHeight),
                              ),
                              itemCount:
                                  allProductsCubit.allProducts!.data.doc.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    navigateTo(
                                      page: DetailsView(
                                        id: allProductsCubit
                                            .allProducts!.data.doc[index].id,
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
                                    favIcon: SvgIcon(
                                      icon: 'assets/icons/heart.svg',
                                      color: ColorManager.white,
                                      height: 18.h,
                                    ),
                                    favTap: () {},
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
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
