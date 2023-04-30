import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';

import 'states.dart';

class NewPasswordCubit extends Cubit<NewPasswordStates> {
  NewPasswordCubit() : super(NewPasswordInitialState());

  static NewPasswordCubit get(context) => BlocProvider.of(context);
  final dio = Dio();
  final formKey = GlobalKey<FormState>();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool securePass = true;
  bool secureConfPass = true;

  Future<void> newPassword() async {
    if (formKey.currentState!.validate()) {
      emit(NewPasswordLoadingState());
      try {

        final response = await dio.patch(
          "${UrlsStrings.otpUrl}/${555555}",
          data: {
            "password": passwordController.text,
            "passwordConfirm": confirmPasswordController.text,
          },
        );

        if (response.data["status"] == "success" &&
            response.statusCode == 200) {
          emit(NewPasswordSuccessState());
        } else {
          emit(NewPasswordFailureState(msg: response.data["message"]));
          print(response.data["message"]);
        }
      } on DioError catch (e) {
        emit(NewPasswordFailureState(msg: "$e"));
        print("$e");
      }
    }
  }


  passwordVisibility() {
    securePass = !securePass;
    emit(NewPasswordVisibilityState());
  }

  confPasswordVisibility() {
    secureConfPass = !secureConfPass;
    emit(NewConfPasswordVisibilityState());
  }
}
