import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';

import 'states.dart';

class OtpCubit extends Cubit<OtpStates> {
  OtpCubit() : super(OtpInitialState());

  static OtpCubit get(context) => BlocProvider.of(context);

  final dio = Dio();
  final otpController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool securePass = true;
  bool secureConfPass = true;

  Future<void> verifyOtp() async {
    emit(OtpLoadingState());
    try {
      final response = await dio.patch(
        "${UrlsStrings.otpUrl}/${otpController.text}",
        data: {
          "password": passwordController.text,
          "passwordConfirm": confirmPasswordController.text,
        },
      );
      if (response.data["status"] == "success" && response.statusCode == 200) {
        CacheHelper.saveToken("${response.data["token"]}");
        emit(OtpSuccessState());
      } else {
        emit(OtpFailureState(msg: response.data["message"]));
      }
    } on DioError catch (e) {
      String errorMessage;
      switch (e.type) {
        case DioErrorType.connectionTimeout:
          errorMessage = "Connection timeout";
          break;
        case DioErrorType.sendTimeout:
          errorMessage = "Send timeout";
          break;
        case DioErrorType.receiveTimeout:
          errorMessage = "Receive timeout";
          break;
        case DioErrorType.badResponse:
          errorMessage = "${e.response?.data["message"]}";
          break;
        case DioErrorType.cancel:
          errorMessage = "Request was cancelled";
          break;
        case DioErrorType.unknown:
        default:
          errorMessage = "An unknown error occurred";
          break;
      }
      emit(OtpFailureState(msg: errorMessage));
    }
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
