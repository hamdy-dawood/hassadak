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
        emit(ForgetPasswordFailureState(msg: "$e"));
      }
    }
  }
}