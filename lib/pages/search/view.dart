import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hassadak/components/back_with_title.dart';
import 'package:hassadak/components/custom_elevated.dart';
import 'package:hassadak/components/error_network.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/shimmer.dart';
import 'package:hassadak/core/snack_and_navigate.dart';
import 'package:hassadak/pages/details/view.dart';
import 'package:hassadak/pages/favourite/add_fav/cubit.dart';
import 'package:hassadak/pages/home/components/product_item.dart';

import 'cubit.dart';

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
      create: (context) => SearchCubit(),
      child: Builder(builder: (context) {
        final searchCubit = SearchCubit.get(context);
        final addFavCubit = AddFavCubit.get(context);
        searchCubit.getSearch();

        return Scaffold(
          backgroundColor: ColorManager.white,
          appBar: backWithTitle(
            context,
            title: "البحث",
          ),
          body: RefreshIndicator(
            backgroundColor: ColorManager.secMainColor,
            color: Colors.white,
            onRefresh: () async {
              await Future.delayed(const Duration(milliseconds: 300));
              searchCubit.getSearch();
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
                                    controller: searchController,
                                    onFieldSubmitted: (_) {
                                      if (searchController.text == "") {
                                        focusNode.unfocus();
                                      } else {
                                        searchCubit.getSearch(
                                            id: "/search/${searchController.text}");
                                      }
                                    },
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
                                  height: 0.4.sh,
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
                                                searchCubit.getSearch(
                                                    id: "?price[gte]=${priceController.text}");
                                                priceController.clear();
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
                                            searchCubit.getSearch(
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
                                            searchCubit.getSearch(
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
                    BlocBuilder<SearchCubit, SearchStates>(
                      builder: (context, state) {
                        if (state is SearchLoadingState) {
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
                        } else if (state is SearchFailedState) {
                          return Center(child: Text(state.msg));
                        } else if (state is SearchNetworkErrorState) {
                          return ErrorNetwork(
                            press: () {
                              searchCubit.getSearch();
                            },
                          );
                        } else {
                          return Expanded(
                            child: GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10.w,
                                crossAxisSpacing: 0.w,
                                childAspectRatio: (itemWidth / itemHeight),
                              ),
                              itemCount:
                                  searchCubit.searchResponse!.data!.doc!.length,
                              itemBuilder: (context, index) {
                                final search = searchCubit
                                    .searchResponse!.data!.doc![index];
                                double number = double.parse(
                                    "${search.price! - (search.price! * (search.discountPerc! / 100))}");
                                String formatOldPrice =
                                    number.toStringAsFixed(2);
                                return BlocBuilder<AddFavCubit, AddFavStates>(
                                  builder: (context, state) {
                                    final favStatus =
                                        addFavCubit.favStatusMap[search.id!] ??
                                            FavStatus(search.status!);
                                    return InkWell(
                                      onTap: () {
                                        navigateTo(
                                          page: DetailsView(
                                            id: "${search.id}",
                                            image: "${search.productUrl}",
                                            userImage: "${search.userPhoto}",
                                            productName: "${search.name}",
                                            userName: "${search.uploaderName}",
                                            desc: "${search.desc}",
                                            telephone: "${search.sellerPhone}",
                                            whatsapp:
                                                "${search.sellerWhatsapp}",
                                            isOffer: search.discountPerc == 0
                                                ? false
                                                : true,
                                            price: formatOldPrice,
                                            oldPrice: "${search.price}",
                                            ratingsAverage:
                                                (search.ratingsAverage)!
                                                    .toInt(),
                                            ratingsQuantity:
                                                (search.ratingsQuantity!),
                                            favStatus: favStatus.isLoved,
                                            uploaderId: "${search.uploaderId}",
                                          ),
                                        );
                                      },
                                      child: ProductItem(
                                        width: 0.41,
                                        favIcon: Icon(
                                          favStatus.isLoved
                                              ? Icons.favorite
                                              : Icons.favorite_outline,
                                          color: favStatus.isLoved
                                              ? ColorManager.green
                                              : ColorManager.white,
                                        ),
                                        favTap: () {
                                          if (search.status! == false) {
                                            addFavCubit.addFav(id: search.id!);
                                            addFavCubit.changeFavourite(
                                                search.id!, search.status!);
                                          } else {
                                            // deleteFavCubit.deleteFav(id: product.id!);
                                            addFavCubit.changeFavourite(
                                                search.id!, search.status!);
                                          }
                                        },
                                        isOffer: search.discountPerc == 0
                                            ? false
                                            : true,
                                        offer: "خصم ${search.discountPerc}%",
                                        title: "${search.name}",
                                        image: "${search.productUrl}",
                                        userName: "${search.uploaderName}",
                                        userImage: "${search.userPhoto}",
                                        price: formatOldPrice,
                                        oldPrice: "${search.price}",
                                      ),
                                    );
                                  },
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
