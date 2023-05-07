import 'package:flutter/material.dart';

class LoginControllers {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final phonePasswordController = TextEditingController();
  final emailPasswordController = TextEditingController();

  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    phonePasswordController.dispose();
    emailPasswordController.dispose();
  }
}
