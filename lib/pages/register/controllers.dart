import 'package:flutter/material.dart';

class RegisterControllers {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final imageController = TextEditingController();
  final userNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    imageController.dispose();
    userNameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
