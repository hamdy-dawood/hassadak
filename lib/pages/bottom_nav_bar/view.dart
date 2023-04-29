import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/pages/About/view.dart';
import 'package:hassadak/pages/bottom_nav_bar/states.dart';
import 'package:hassadak/pages/company/view.dart';
import 'package:hassadak/pages/favourite/view.dart';
import 'package:hassadak/pages/home/view.dart';

import 'bottom_bar_item.dart';
import 'cubit.dart';

class NavBarView extends StatelessWidget {
  const NavBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List screens = const [
      HomeView(),
      FavouriteView(),
      CompanyView(),
      AboutView(),
      // ProfileView(),
    ];
    return BlocProvider(
      create: (context) => NavBarCubit(),
      child: Builder(builder: (context) {
        final cubit = NavBarCubit.get(context);
        return BlocBuilder<NavBarCubit, NavBarStates>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: ColorManager.white,
              key: cubit.scaffoldKey,
              body: screens[cubit.controller.selectedItem],
              bottomNavigationBar: SizedBox(
                height: 60.h,
                child: BottomAppBar(
                  color: ColorManager.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      cubit.controller.icons.length,
                      (index) => BottomBarItem(
                        onPress: () {
                          cubit.selectItem(index);
                        },
                        icon: cubit.controller.icons[index],
                        label: cubit.controller.labels[index],
                        isSelected: index == cubit.controller.selectedItem,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
