import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_depi_final_project/Screens/HomeScreen.dart';
import '../Services/AuthService.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var showPassword = false.obs;
  var isLoading = false.obs;

  void togglePassword() {
    showPassword.value = !showPassword.value;
  }

  Future<void> login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    try {
      isLoading.value = true;

      final user = await AuthService().login(username, password);

      isLoading.value = false;

      if (user != null) {
        Get.snackbar("Success", "Login Successful", backgroundColor: Colors.green.shade400,
            colorText: Colors.white);

        Get.off(HomeScreen());
      } else {
        Get.snackbar("Error","Invalid username or password",
            backgroundColor: Colors.redAccent,
            colorText: Colors.white);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }
}
