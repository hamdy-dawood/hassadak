import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';

import 'states.dart';

class OtpCubit extends Cubit<OtpStates> {
  OtpCubit() : super(OtpInitialState());

  static OtpCubit get(context) => BlocProvider.of(context);

  final otpController = TextEditingController();

  Future<void> verifyOtp() async {
    emit(OtpLoadingState());
    try {
      final response =
          await Dio().patch("${UrlsStrings.otpUrl}/${otpController.text}");
      if (response.data["status"] == "success" && response.statusCode == 200) {
        print(response.data);
        emit(OtpSuccessState(msg: response.data["message"]));
      } else {
        emit(OtpFailureState(msg: response.data["message"]));
        print(response.data["message"]);
      }
    } on DioError catch (e) {
      emit(OtpFailureState(msg: "$e"));
    }
  }
}
