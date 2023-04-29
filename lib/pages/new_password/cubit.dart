import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'states.dart';

class NewPasswordCubit extends Cubit<NewPasswordStates> {
  NewPasswordCubit() : super(NewPasswordInitialState());

  static NewPasswordCubit get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool securePass = true;
  bool secureConfPass = true;

  Future<void> newPassword() async {
    if (formKey.currentState!.validate()) {
      emit(NewPasswordSuccessState());
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
