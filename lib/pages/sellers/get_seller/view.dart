import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/constants/shimmer.dart';

import 'cubit.dart';

class GetSellerView extends StatelessWidget {
  const GetSellerView({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetSellerCubit(),
      child: Builder(builder: (context) {
        final cubit = GetSellerCubit.get(context);
        cubit.getSeller(id: id);
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
          ),
          body: SizedBox(
            height: 1.sh,
            width: 1.sw,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: BlocBuilder<GetSellerCubit, GetSellerStates>(
                builder: (context, state) {
                  if (state is GetSellerLoadingState) {
                    // return ListView(
                    //   children: [
                    //     SizedBox(
                    //       height: 0.02.sh,
                    //     ),
                    //     ContainerShimmer(
                    //       height: 0.15.sh,
                    //       width: 0.15.sh,
                    //       margin: EdgeInsets.all(0.h),
                    //       padding: EdgeInsets.all(0.h),
                    //       radius: 50.r,
                    //     ),
                    //     SizedBox(
                    //       height: 0.02.sh,
                    //     ),
                    //     ContainerShimmer(
                    //       height: 20.h,
                    //       width: 100.w,
                    //       margin: EdgeInsets.all(0.h),
                    //       padding: EdgeInsets.all(0.h),
                    //     ),
                    //     SizedBox(
                    //       height: 0.02.sh,
                    //     ),
                    //     Align(
                    //       alignment: Alignment.centerRight,
                    //       child: ContainerShimmer(
                    //         height: 30.h,
                    //         width: 100.w,
                    //         margin: EdgeInsets.all(0.h),
                    //         padding: EdgeInsets.all(0.h),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       height: 0.02.sh,
                    //     ),
                    //     Align(
                    //       alignment: Alignment.centerRight,
                    //       child: ListView.builder(
                    //         itemCount: 6,
                    //         itemBuilder: (context, index) => ContainerShimmer(
                    //           height: 20.h,
                    //           width: 0.8.sw,
                    //           margin: EdgeInsets.all(5.h),
                    //           padding: EdgeInsets.all(0.h),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // );
                    return ListView.separated(
                        shrinkWrap: true,
                        itemCount: 5,
                        separatorBuilder: (context, index) => SizedBox(
                              height: 10.w,
                            ),
                        itemBuilder: (context, index) {
                          return ContainerShimmer(
                            height: 50.h,
                            width: 0.85.sw,
                            margin: EdgeInsets.all(12.h),
                            padding: EdgeInsets.all(12.h),
                          );
                        });
                  } else if (state is GetSellerFailedState) {
                    return Text(state.msg);
                  } else {
                    return ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Container(
                            height: 0.15.sh,
                            decoration: BoxDecoration(
                              color: ColorManager.secMainColor,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.5),
                              child: Image.asset(
                                "assets/images/user.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        CustomText(
                          textAlign: TextAlign.center,
                          text: cubit.sellerResponse!.user.username,
                          color: ColorManager.secMainColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 25.sp,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        CustomText(
                          textAlign: TextAlign.center,
                          text: cubit.sellerResponse!.user.email,
                          color: ColorManager.secMainColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 20.sp,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomText(
                          text: "نبذة عني",
                          color: ColorManager.secMainColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 25.sp,
                        ),
                        SizedBox(
                          height: 0.01.sh,
                        ),
                        CustomText(
                          text:
                              "يعد اكسايت الغانم للالكترونيات أكبر موزع للالكترونيات في الكويت ويضم العديد من العلامات التجارية من بينها ما يفوق الـ٣٠٠ علامة تجارية عالمية. أما شركة صناعات الغانم التي يندرج تحتها اكسايت فهي واحدة من أكبر شركات القطاع الخاص في منطقة الخليج. وهي تمارس أنشطتها المتعددة في ٤٠ دولة وفي أكثر من ٣٠ مجال.",
                          color: ColorManager.navGrey,
                          fontWeight: FontWeight.normal,
                          fontSize: 20.sp,
                          maxLines: 5,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomText(
                          text: "تابعنا على",
                          color: ColorManager.secMainColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 25.sp,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: SvgPicture.asset(
                                "assets/icons/whatsapp.svg",
                                height: 50.h,
                              ),
                            ),
                            SizedBox(
                              width: 10.h,
                            ),
                            InkWell(
                              onTap: () {},
                              child: SvgPicture.asset(
                                "assets/icons/twitter.svg",
                                height: 50.h,
                              ),
                            ),
                            SizedBox(
                              width: 10.h,
                            ),
                            InkWell(
                              onTap: () {},
                              child: SvgPicture.asset(
                                "assets/icons/instagram.svg",
                                height: 50.h,
                              ),
                            ),
                            SizedBox(
                              width: 10.h,
                            ),
                            InkWell(
                              onTap: () {},
                              child: SvgPicture.asset(
                                "assets/icons/facebook.svg",
                                height: 50.h,
                              ),
                            ),
                          ],
                        ),
                      ],
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
