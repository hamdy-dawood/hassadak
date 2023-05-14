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

  Future<void> emailLogin() async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoadingState());
      try {
        final emailResponse =
            await Dio().post(UrlsStrings.emailLoginUrl, data: {
          "email": controllers.emailController.text,
          "password": controllers.emailPasswordController.text,
        });
        if (emailResponse.data["status"] == "success" &&
            emailResponse.statusCode == 200) {
          loginResponse = LoginResponse.fromJson(emailResponse.data);
          CacheHelper.saveToken("${emailResponse.data["token"]}");
          CacheHelper.saveId("${loginResponse!.data!.user!.id}");
          emit(LoginSuccessState());
        } else {
          emit(LoginFailureState(msg: emailResponse.data["status"]));
        }
      } on DioError catch (e) {
        String errorMsg;
        if (e.type == DioErrorType.cancel) {
          errorMsg = 'Request was cancelled';
          emit(LoginFailureState(msg: errorMsg));
        } else if (e.type == DioErrorType.connectionTimeout ||
            e.type == DioErrorType.receiveTimeout ||
            e.type == DioErrorType.sendTimeout) {
          errorMsg = 'Connection timed out';
          emit(LoginFailureState(msg: errorMsg));
        } else if (e.type == DioErrorType.badResponse) {
          errorMsg = 'Invalid status code: ${e.response?.statusCode}';
          emit(LoginFailureState(msg: errorMsg));
        } else {
          errorMsg = 'An unexpected error : ${e.error}';
          emit(LoginFailureState(msg: errorMsg));
        }
      } catch (e) {
        emit(LoginFailureState(msg: 'An unknown error: $e'));
      }
    }
  }

  Future<void> phoneLogin() async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoadingState());
      try {
        final phoneResponse =
            await Dio().post(UrlsStrings.phoneLoginUrl, data: {
          "telephone": controllers.phoneController.text,
          "password": controllers.phonePasswordController.text,
        });
        if (phoneResponse.data["status"] == "success" &&
            phoneResponse.statusCode == 200) {
          loginResponse = LoginResponse.fromJson(phoneResponse.data);
          CacheHelper.saveToken("${phoneResponse.data["token"]}");
          CacheHelper.saveId("${loginResponse!.data!.user!.id}");
          emit(LoginSuccessState());
        } else {
          emit(LoginFailureState(msg: phoneResponse.data["status"]));
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

  @override
  Future<void> close() {
    controllers.dispose();
    return super.close();
  }
}
