import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/constants/shimmer.dart';
import 'package:hassadak/pages/login/cubit.dart';
import 'package:hassadak/pages/login/states.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: Builder(builder: (context) {
          final cubit = LoginCubit.get(context);
          cubit.login();
          cubit.loginResponse;
          return SizedBox(
            width: 1.sw,
            height: 1.sh,
            child: BlocBuilder<LoginCubit, LoginStates>(
              builder: (context, state) {
                if (state is LoginLoadingState) {
                  return Padding(
                    padding: EdgeInsets.only(top: 20.h),
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
                } else if (state is LoginFailureState) {
                  return Text(state.msg);
                } else {
                  return ListView(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: ColorManager.mainColor,
                      ),
                      CustomText(
                        text: "${cubit.loginResponse!.data.user.email}",
                        color: ColorManager.red,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      CustomText(
                        text: "${cubit.loginResponse!.data.user.telephone}",
                        color: ColorManager.red,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  );
                }
              },
            ),
          );
        }),
      ),
    );
  }
}
