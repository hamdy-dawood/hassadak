import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';

import 'states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool securePass = true;
  bool secureConfPass = true;

  Future<void> register() async {
    emit(RegisterLoadingState());
    if (formKey.currentState!.validate()) {
      try {
        final response = await Dio().post(UrlsStrings.registerUrl, data: {
          "firstName": firstNameController.text,
          "lastName": lastNameController.text,
          "email": emailController.text,
          "username": userNameController.text,
          "telephone": phoneController.text,
          "password": passwordController.text,
          "passwordConfirm": confirmPasswordController.text,
        });
        if (response.data["status"] == "success" &&
            response.statusCode == 200) {
          CacheHelper.saveToken("${response.data["token"]}");
          // CacheHelper.saveEmail(emailController.text);
          // CacheHelper.savePass(passwordController.text);
          emit(RegisterSuccessState());
        } else {
          emit(RegisterFailureState(msg: response.data["status"]));
        }
      } on DioError catch (e) {
        emit(RegisterFailureState(msg: "$e"));
      }
    }
  }

  passwordVisibility() {
    securePass = !securePass;
    emit(PasswordVisibilityState());
  }

  confPasswordVisibility() {
    secureConfPass = !secureConfPass;
    emit(ConfPasswordVisibilityState());
  }
}
