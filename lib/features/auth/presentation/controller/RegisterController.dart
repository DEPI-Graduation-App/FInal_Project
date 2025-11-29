import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_depi_final_project/core/routes/app_pages.dart';
import '../../data/services/AuthService.dart';

class RegisterController extends GetxController {
  final service = Get.put(AuthService());
  final EmailController = TextEditingController();
  final UsernameController = TextEditingController();
  final PasswordController = TextEditingController();
  final RepasswordController = TextEditingController();

  var isLoading = false.obs;
  var showPassword = false.obs;
  var showRePassword = false.obs;

  void togglePassword() => showPassword.value = !showPassword.value;
  void toggleRePassword() => showRePassword.value = !showRePassword.value;

  Future<void> register() async {
    final email = EmailController.text.trim();
    final username = UsernameController.text.trim();
    final password = PasswordController.text.trim();
    final rePassword = RepasswordController.text.trim();

    if (email.isEmpty ||
        username.isEmpty ||
        password.isEmpty ||
        rePassword.isEmpty) {
      _showError("Please fill all fields");
      return;
    }

    if (!email.isEmail) {
      _showError("Please enter a valid email");
      return;
    }

    if (password.length < 6) {
      _showError("Password must be at least 6 characters");
      return;
    }

    if (password != rePassword) {
      _showError("Passwords do not match");
      return;
    }

    try {
      isLoading.value = true;
      final result = await service.register(email, password, username);
      isLoading.value = false;

      if (result != null) {
        Get.snackbar(
          "Success",
          "Account created successfully!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed(AppPages.layout);
      } else {
        _showError("Email is already registered or invalid");
      }
    } catch (e) {
      isLoading.value = false;

      if (e.toString().contains("email_address already exists")) {
        _showError("Email already registered. Try logging in.");
      } else if (e.toString().contains("password")) {
        _showError("Weak password. Try a stronger password.");
      } else {
        _showError("Unexpected error: ${e.toString()}");
      }
    }
  }

  void _showError(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
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
