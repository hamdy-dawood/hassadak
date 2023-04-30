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
  final currentPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool currentPass = true;
  bool securePass = true;
  bool secureConfPass = true;

  Future<void> newPassword() async {
    if (formKey.currentState!.validate()) {
      emit(NewPasswordLoadingState());
      try {
        dio.options.headers['Authorization'] = 'Bearer ${CacheHelper.getToken()}';
        final response = await dio.patch(
          UrlsStrings.updatePassUrl,
          data: {
            "passwordCurrent": currentPasswordController.text,
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

  currentPassVisibility() {
    currentPass = !currentPass;
    emit(CurrentPassVisibilityState());
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
