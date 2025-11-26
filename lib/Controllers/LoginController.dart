import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';
import '../Services/AuthService.dart';

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
      Get.snackbar("Error", "Please fill all fields");
      return false;
    }

    try {
      isLoading.value = true;
      final user = await service.login(email, password);
      isLoading.value = false;

      if (user != null) {
        Get.snackbar(
          "Success",
          "Login Successful",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        return true;
      } else {

        /// This will catch unsuccessful authentication without throwing an error.
        Get.snackbar(
          "Error",
          "Invalid credentials",
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
          "Wrong password",
          "Please try again",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      } else if (e.message.contains("Email not found")) {
        Get.snackbar(
          "Email not found",
          "Try signing up",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      } else {
        Get.snackbar(
          "Authentication Error",
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
        "Error",
        e.toString(),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }
  }
}
