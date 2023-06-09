import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';

import 'controllers.dart';
import 'model.dart';
import 'states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  bool securePass = true;
  bool secureConfPass = true;
  RegisterResponse? registerResponse;
  bool showVisibilityIcon = true;

  final controllers = RegisterControllers();

  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      showVisibilityIcon = false;
      emit(RegisterLoadingState());
      try {
        final response = await Dio().post(UrlsStrings.registerUrl, data: {
          "firstName": controllers.firstNameController.text,
          "lastName": controllers.lastNameController.text,
          "email": controllers.emailController.text,
          "username": controllers.userNameController.text,
          "telephone": controllers.phoneController.text,
          "password": controllers.passwordController.text,
          "passwordConfirm": controllers.confirmPasswordController.text,
        });
        if (response.data["status"] == "success" &&
            response.statusCode == 201) {
          registerResponse = RegisterResponse.fromJson(response.data);
          CacheHelper.saveToken("${response.data["token"]}");
          CacheHelper.saveId("${registerResponse!.data!.user!.id}");
          emit(RegisterSuccessState());
          showVisibilityIcon = true;
        } else {
          emit(RegisterFailureState(msg: response.data["status"]));
          showVisibilityIcon = true;
        }
      } on DioError catch (e) {
        String errorMsg;
        if (e.type == DioErrorType.cancel) {
          errorMsg = 'Request was cancelled';
          emit(RegisterFailureState(msg: errorMsg));
          showVisibilityIcon = true;
        } else if (e.type == DioErrorType.receiveTimeout ||
            e.type == DioErrorType.sendTimeout) {
          errorMsg = 'Connection timed out';
          emit(NetworkErrorState());
          showVisibilityIcon = true;
        } else if (e.type == DioErrorType.other) {
          errorMsg = 'Invalid status code: ${e.response!.statusMessage}';
          emit(RegisterFailureState(msg: errorMsg));
          emit(NetworkErrorState());
        } else {
          errorMsg = 'An unexpected error : ${e.error}';
          emit(RegisterFailureState(msg: errorMsg));
          showVisibilityIcon = true;
        }
      } catch (e) {
        emit(RegisterFailureState(msg: 'An unknown error: $e'));
        showVisibilityIcon = true;
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

  @override
  Future<void> close() {
    controllers.dispose();
    return super.close();
  }
}
