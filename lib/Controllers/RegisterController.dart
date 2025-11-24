import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final EmailController = TextEditingController();
  final UsernameController = TextEditingController();
  final PasswordController = TextEditingController();
  final RepasswordController = TextEditingController();

  var isLoading = false.obs;

  var showPassword = false.obs;
  var showRePassword = false.obs;

  void togglePassword() {
    showPassword.value = !showPassword.value;
  }

  void toggleRePassword() {
    showRePassword.value = !showRePassword.value;
  }

  @override
  void onClose() {
    EmailController.dispose();
    UsernameController.dispose();
    PasswordController.dispose();
    RepasswordController.dispose();
    super.onClose();
  }
}
