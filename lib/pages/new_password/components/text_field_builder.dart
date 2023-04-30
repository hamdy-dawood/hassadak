import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hassadak/components/custom_form_field.dart';
import 'package:hassadak/components/svg_icons.dart';
import 'package:hassadak/constants/color_manager.dart';
import 'package:hassadak/pages/new_password/cubit.dart';
import 'package:hassadak/pages/new_password/states.dart';

class TextFieldBuilder extends StatelessWidget {
  const TextFieldBuilder({
    Key? key,
    required this.controller,
    required this.hint,
    required this.secure,
    required this.suffixTap,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  final bool secure;
  final VoidCallback suffixTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewPasswordCubit, NewPasswordStates>(
      builder: (context, state) {
        return CustomTextFormField(
          controller: controller,
          hint: hint,
          prefixIcon: Padding(
            padding: EdgeInsets.all(8.0.w),
            child: SvgIcon(
              icon: "assets/icons/lock.svg",
              color: ColorManager.grey,
              height: 10.h,
            ),
          ),
          suffixIcon: IconButton(
            onPressed: suffixTap,
            icon: Icon(
              secure
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
            ),
            color: ColorManager.navGrey,
          ),
          obscureText: secure,
          isLastInput: false,
          validator: (value) {
            if (value!.isEmpty) {
              return "من فضلك ادخل كلمة المرور !";
            }
            return null;
          },
        );
      },
    );
  }
}
