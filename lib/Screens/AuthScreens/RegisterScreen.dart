import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_depi_final_project/Management/AssetsManager.dart';
import 'package:news_depi_final_project/widgets/BuildTextField.dart';
import 'package:news_depi_final_project/widgets/CustomTextAlignment.dart';
import 'package:news_depi_final_project/Screens/AuthScreens/LoginScreen.dart';
import '../../Controllers/RegisterController.dart';
import '../../Services/AuthService.dart';
import '../HomeScreen.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  void register() async {
    final email = controller.EmailController.text.trim();
    final username = controller.UsernameController.text.trim();
    final password = controller.PasswordController.text.trim();
    final rePassword = controller.RepasswordController.text.trim();

    if (email.isEmpty || username.isEmpty || password.isEmpty || rePassword.isEmpty) {
      Get.snackbar("Error", "Please fill all fields",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent);
      return;
    }

    if (!email.contains("@")) {
      Get.snackbar("Error", "Please enter a valid email",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent);
      return;
    }

    if (password.length < 6) {
      Get.snackbar("Error", "Password must be at least 6 characters",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent);
      return;
    }

    if (password != rePassword) {
      Get.snackbar("Error", "Passwords do not match",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent);
      return;
    }

    try {
      controller.isLoading.value = true;

      final result = await AuthService().register(email, password, username);

      controller.isLoading.value = false;

      if (result != null) {
        Get.snackbar(
          "Success",
          "Account created successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offAll(HomeScreen());
      }
    } catch (e) {
      controller.isLoading.value = false;

      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f4ef),
      appBar: AppBar(
        backgroundColor: const Color(0xfff7f4ef),
        title: const Text("Register"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Image.asset(
              AssetsManager.logo,
              width: 300,
              height: 140,
            ),

            const Text(
              "welcome to our app",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xff47515b),
              ),
            ),

            const Divider(),
            const SizedBox(height: 10),

            const CustomTextAlignment(text: "Email"),
            const SizedBox(height: 8),
            CustomTextField(
              controller: controller.EmailController,
              keyboardType: TextInputType.emailAddress,
              hint: "Enter your email",
            ),
            const SizedBox(height: 20),

            const CustomTextAlignment(text: "Username"),
            const SizedBox(height: 8),
            CustomTextField(
              controller: controller.UsernameController,
              hint: "Enter your username",
            ),
            const SizedBox(height: 20),

            const CustomTextAlignment(text: "Password"),
            const SizedBox(height: 8),
            Obx(() => CustomTextField(
              controller: controller.PasswordController,
              obscureText: !controller.showPassword.value,
              hint: "Enter your password",
              suffixIcon: IconButton(
                icon: Icon(
                  controller.showPassword.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: controller.togglePassword,
              ),
            )),
            const SizedBox(height: 20),

            const CustomTextAlignment(text: "Confirm Password"),
            const SizedBox(height: 8),
            Obx(() => CustomTextField(
              controller: controller.RepasswordController,
              obscureText: !controller.showRePassword.value,
              hint: "Re-enter your password",
              suffixIcon: IconButton(
                icon: Icon(
                  controller.showRePassword.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: controller.toggleRePassword,
              ),
            )),
            const SizedBox(height: 30),

            Obx(() => controller.isLoading.value
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: register,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 120, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text("Register"),
            )),

            const SizedBox(height: 20),

            InkWell(
              onTap: () => Get.off(LoginScreen()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Already have an account? "),
                  Text("login", style: TextStyle(color: Colors.red)),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
