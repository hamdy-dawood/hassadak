import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';

import 'model.dart';
import 'states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscure = true;
  LoginResponse? loginResponse;

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoadingState());
      try {
        final response = await Dio().post(UrlsStrings.loginUrl, data: {
          "email": emailController.text,
          "password": passwordController.text,
        });
        if (response.data["status"] == "success" &&
            response.statusCode == 200) {
          loginResponse = LoginResponse.fromJson(response.data);
          print(loginResponse!.data.user.email);
          CacheHelper.saveToken("${response.data["token"]}");
          // CacheHelper.saveEmail(emailController.text);
          // CacheHelper.savePass(passwordController.text);
          emit(LoginSuccessState());
        } else {
          emit(LoginFailureState(msg: response.data["status"]));
        }
      } on DioError catch (e) {
        emit(LoginFailureState(msg: "$e"));
      }
    }
  }

  changeVisibility() {
    isObscure = !isObscure;
    emit(ChanceVisibilityState());
  }
}
