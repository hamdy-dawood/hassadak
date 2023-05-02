import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/constants/custom_text.dart';
import 'package:hassadak/constants/shimmer.dart';
import 'package:hassadak/pages/profile/components/build_text_field_with_text.dart';
import 'package:hassadak/pages/profile/personal_data/states.dart';

import 'cubit.dart';

class PersonalDataView extends StatelessWidget {
  const PersonalDataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PersonalDataCubit(),
      child: Builder(builder: (context) {
        final cubit = PersonalDataCubit.get(context);
        cubit.getPersonalData();
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
            actions: [
              IconButton(
                onPressed: () {},
                icon: SvgIcon(
                  icon: "assets/icons/edit.svg",
                  height: 20.h,
                  color: ColorManager.black,
                ),
              ),
            ],
            title: CustomText(
              text: "معلوماتى الشخصية",
              color: ColorManager.mainColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          body: SizedBox(
            width: 1.sw,
            height: 1.sh,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: BlocBuilder<PersonalDataCubit, PersonalDataStates>(
                builder: (context, state) {
                  if (state is PersonalDataLoadingState) {
                    return ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          height: 150.h,
                        ),
                        SizedBox(
                          child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 5,
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 20.h,
                                  ),
                              itemBuilder: (context, index) {
                                return ContainerShimmer(
                                  height: 50.h,
                                  width: 0.85.sw,
                                  margin: EdgeInsets.all(0.h),
                                  padding: EdgeInsets.all(0.h),
                                );
                              }),
                        ),
                      ],
                    );
                  } else if (state is PersonalDataFailureState) {
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
                          text: cubit.profileResponse!.data.doc.username,
                          color: ColorManager.secMainColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 25.sp,
                        ),
                        SizedBox(
                          height: 0.02.sh,
                        ),
                        TextFieldWithText(
                          title: "الاسم الاول",
                          hint: cubit.profileResponse!.data.doc.firstName,
                        ),
                        TextFieldWithText(
                          title: "الاسم الاخير",
                          hint: cubit.profileResponse!.data.doc.lastName,
                        ),
                        TextFieldWithText(
                          title: "اسم المستخدم",
                          hint: cubit.profileResponse!.data.doc.username,
                        ),
                        TextFieldWithText(
                          title: "رقم الهاتف",
                          hint: cubit.profileResponse!.data.doc.telephone,
                        ),
                        TextFieldWithText(
                          title: "البريد الالكترونى",
                          hint: cubit.profileResponse!.data.doc.email,
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
