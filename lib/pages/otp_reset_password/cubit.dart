import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';

import 'model.dart';
import 'states.dart';

class OtpCubit extends Cubit<OtpStates> {
  OtpCubit() : super(OtpInitialState());

  static OtpCubit get(context) => BlocProvider.of(context);

  final dio = Dio();
  ResetPassOtpResponse? newPassOtpResponse;

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
        newPassOtpResponse = ResetPassOtpResponse.fromJson(response.data);
        CacheHelper.saveToken("${response.data["token"]}");
        CacheHelper.saveId("${newPassOtpResponse!.data!.user!.id}");
        emit(OtpSuccessState());
      } else {
        emit(OtpFailureState(msg: response.data["message"]));
      }
    } on DioError catch (e) {
      String errorMsg;
      if (e.type == DioErrorType.cancel) {
        errorMsg = 'Request was cancelled';
        emit(OtpFailureState(msg: errorMsg));
      } else if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
        emit(OtpFailureState(msg: errorMsg));
      } else if (e.type == DioErrorType.other) {
        errorMsg = 'Invalid status code: ${e.response?.statusCode}';
        emit(OtpFailureState(msg: errorMsg));
      } else {
        errorMsg = 'An unexpected error : ${e.error}';
        emit(OtpFailureState(msg: errorMsg));
      }
    } catch (e) {
      emit(OtpFailureState(msg: 'An unknown error: $e'));
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
