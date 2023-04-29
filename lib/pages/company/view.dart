import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/company_list_item.dart';
import 'package:hassadak/constants/app_bar.dart';
import 'package:hassadak/constants/color_manager.dart';

class CompanyView extends StatelessWidget {
  const CompanyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: customAppBar(text: "الشركات"),
      body: SizedBox(
        height: 0.95.sh,
        width: double.infinity,
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          shrinkWrap: true,
          itemCount: 6,
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 10.w,
            );
          },
          itemBuilder: (context, index) {
            return CustomListTile(
              onTap: () {},
              title: "محمد علي",
              image: "assets/images/user.png",
            );
          },
        ),
      ),
    );
  }
}
