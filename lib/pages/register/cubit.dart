import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';

import 'states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool securePass = true;
  bool secureConfPass = true;

  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      emit(RegisterLoadingState());
      final response = await Dio().post(UrlsStrings.registerUrl, data: {
        "firstName": firstNameController.text,
        "lastName": secondNameController.text,
        "email": emailController.text,
        "username": userNameController.text,
        "telephone": phoneController.text,
        "password": passwordController.text,
        "passwordConfirm": confirmPasswordController.text,
      });
      if (response.data["status"] == "success" && response.statusCode == 200) {
        emit(RegisterSuccessState());
      } else {
        emit(RegisterFailureState(msg: response.data["status"]));
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
