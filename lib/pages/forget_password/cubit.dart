import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';

import 'states.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  ForgetPasswordCubit() : super(ForgetPasswordInitialState());

  static ForgetPasswordCubit get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  Future<void> sendEmail() async {
    if (formKey.currentState!.validate()) {
      emit(ForgetPasswordLoadingState());
      try {
        final response = await Dio().post(UrlsStrings.forgetPassUrl, data: {
          "email": emailController.text,
        });
        if (response.data["status"] == "success" &&
            response.statusCode == 200) {
          emit(ForgetPasswordSuccessState(msg: response.data["message"]));
        } else {
          emit(ForgetPasswordFailureState(msg: response.data["message"]));
        }
      } on DioError catch (e) {
        if (e.type == DioErrorType.connectTimeout) {
          emit(ForgetPasswordFailureState(
              msg:
                  "Connection timeout. Please check your internet connection."));
        } else if (e.type == DioErrorType.receiveTimeout) {
          emit(ForgetPasswordFailureState(
              msg: "Receive timeout. Please check your internet connection."));
        } else if (e.type == DioErrorType.other) {
          emit(ForgetPasswordFailureState(
              msg: "${e.response?.data["message"]}"));
        } else if (e.type == DioErrorType.cancel) {
          emit(ForgetPasswordFailureState(msg: "Request canceled."));
        } else {
          emit(
              ForgetPasswordFailureState(msg: "An unknown error occurred: $e"));
        }
      }
    }
  }
}
