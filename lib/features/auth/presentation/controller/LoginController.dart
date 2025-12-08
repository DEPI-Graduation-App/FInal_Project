import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_depi_final_project/core/routes/app_pages.dart';
import 'package:supabase/supabase.dart';
import 'package:news_depi_final_project/generated/l10n.dart';
import '../../data/services/AuthService.dart';

class LoginController extends GetxService {
  final service = Get.put(AuthService());
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var showPassword = false.obs;
  var isLoading = false.obs;

  void togglePassword() {
    showPassword.value = !showPassword.value;
  }

  Future<bool> login() async {
    final email = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(S.current.error, S.current.pleaseFillAllFields);
      return false;
    }

    try {
      isLoading.value = true;
      final user = await service.login(email, password);
      isLoading.value = false;

      if (user != null) {
        Get.snackbar(
          S.current.success,
          S.current.loginSuccessful,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        return true;
      } else {
        /// This will catch unsuccessful authentication without throwing an error.
        Get.snackbar(
          S.current.error,
          S.current.invalidCredentials,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return false;
      }
    } on AuthException catch (e) {
      isLoading.value = false;

      if (e.message.contains("Invalid login credentials")) {
        Get.snackbar(
          S.current.wrongPassword,
          S.current.pleaseTryAgain,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      } else if (e.message.contains("Email not found")) {
        Get.snackbar(
          S.current.emailNotFound,
          S.current.trySigningUp,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      } else {
        Get.snackbar(
          S.current.authenticationError,
          e.message,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
      return false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        S.current.error,
        e.toString(),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }
  }
}
