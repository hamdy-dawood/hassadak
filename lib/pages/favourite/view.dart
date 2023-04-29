import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/favourite_item.dart';
import 'package:hassadak/constants/app_bar.dart';
import 'package:hassadak/constants/color_manager.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: customAppBar(text: "المفضلة"),
      body: SizedBox(
        width: double.infinity,
        child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            shrinkWrap: true,
            itemCount: 4,
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10.w,
              );
            },
            itemBuilder: (context, index) {
              return const FavouriteItem();
            }),
      ),
    );
  }
}
