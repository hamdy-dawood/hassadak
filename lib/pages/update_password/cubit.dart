import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';

import 'states.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordStates> {
  UpdatePasswordCubit() : super(UpdatePasswordInitialState());

  static UpdatePasswordCubit get(context) => BlocProvider.of(context);

  final dio = Dio();
  final formKey = GlobalKey<FormState>();

  final currentPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool currentPass = true;
  bool securePass = true;
  bool secureConfPass = true;

  Future<void> updatePassword() async {
    if (formKey.currentState!.validate()) {
      emit(UpdatePasswordLoadingState());
      try {
        dio.options.headers['Authorization'] =
            'Bearer ${CacheHelper.getToken()}';
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
          emit(UpdatePasswordSuccessState());
          currentPasswordController.clear();
          passwordController.clear();
          confirmPasswordController.clear();
        } else {
          emit(UpdatePasswordFailureState(msg: response.data["message"]));
          print(response.data["message"]);
        }
      } on DioError catch (e) {
        emit(UpdatePasswordFailureState(msg: "$e"));
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
    emit(UpdatePasswordVisibilityState());
  }

  confPasswordVisibility() {
    secureConfPass = !secureConfPass;
    emit(UpdateConfPasswordVisibilityState());
  }
}
