import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/custom_form_field.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/pages/update_password/cubit.dart';
import 'package:hassadak/pages/update_password/states.dart';

class BuildTextField extends StatelessWidget {
  const BuildTextField({
    Key? key,
    required this.controller,
    required this.hint,
    required this.suffixPress,
    required this.visibility,
  }) : super(key: key);
  final TextEditingController controller;
  final String hint;
  final VoidCallback suffixPress;
  final bool visibility;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdatePasswordCubit, UpdatePasswordStates>(
      builder: (context, state) {
        return CustomTextFormField(
          controller: controller,
          hint: hint,
          prefixIcon: Padding(
            padding: EdgeInsets.all(8.w),
            child: SvgIcon(
              icon: "assets/icons/lock.svg",
              color: ColorManager.grey,
              height: 10.h,
            ),
          ),
          suffixIcon: IconButton(
            onPressed: suffixPress,
            icon: Icon(
              visibility
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
            ),
            color: ColorManager.navGrey,
          ),
          obscureText: visibility,
          isLastInput: false,
          validator: (value) {
            if (value!.isEmpty) {
              return 'من فضلك ادخل كلمة المرور !';
            }
            return null;
          },
        );
      },
    );
  }
}
