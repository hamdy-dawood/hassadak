import 'package:flutter/material.dart';

class EditDataControllers {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final userNameController = TextEditingController();
  final phoneController = TextEditingController();

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();
    phoneController.dispose();
  }
}
