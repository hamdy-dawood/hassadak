import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';

import 'controller.dart';
import 'model.dart';
import 'states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  bool isObscure = true;
  LoginResponse? loginResponse;

  final controllers = LoginControllers();

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoadingState());
      try {
        final emailResponse =
            await Dio().post(UrlsStrings.emailLoginUrl, data: {
          "email": controllers.emailController.text,
          "password": controllers.passwordController.text,
        });
        if (emailResponse.data["status"] == "success" &&
            emailResponse.statusCode == 200) {
          loginResponse = LoginResponse.fromJson(emailResponse.data);
          print(loginResponse!.data.user.email);
          CacheHelper.saveToken("${emailResponse.data["token"]}");
          emit(LoginSuccessState());
        } else {
          emit(LoginFailureState(msg: emailResponse.data["status"]));
        }
      } on DioError catch (e) {
        emit(LoginFailureState(msg: "$e"));
      }

      // try {
      //   final phoneResponse =
      //       await Dio().post(UrlsStrings.phoneLoginUrl, data: {
      //     "telephone": controllers.emailController.text,
      //     "password": controllers.passwordController.text,
      //   });
      //   if (phoneResponse.data["status"] == "success" &&
      //       phoneResponse.statusCode == 200) {
      //     loginResponse = LoginResponse.fromJson(phoneResponse.data);
      //     print(loginResponse!.data.user.email);
      //     CacheHelper.saveToken("${phoneResponse.data["token"]}");
      //     emit(LoginSuccessState());
      //   } else {
      //     emit(LoginFailureState(msg: phoneResponse.data["status"]));
      //   }
      // } on DioError catch (e) {
      //   emit(LoginFailureState(msg: "$e"));
      // }

    }
  }

  changeVisibility() {
    isObscure = !isObscure;
    emit(ChanceVisibilityState());
  }

  @override
  Future<void> close() {
    controllers.dispose();
    return super.close();
  }
}
