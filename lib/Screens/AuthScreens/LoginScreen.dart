import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_depi_final_project/Screens/AuthScreens/ForgotPasswordScreen.dart';
import 'package:news_depi_final_project/Screens/AuthScreens/RegisterScreen.dart';
import '../../Controllers/LoginController.dart';
import '../../Roads/road.dart';
import '../../widgets/BuildTextField.dart';
import '../../Management/AssetsManager.dart';
import '../../widgets/CustomTextAlignment.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f4ef),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 40),

              Image.asset(
                AssetsManager.logo,
                width: 300,
                height: 140,
                fit: BoxFit.contain,
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
              const SizedBox(height: 30),

              CustomTextAlignment(text: 'Email Address'),
              const SizedBox(height: 8),
              CustomTextField(controller: controller.usernameController),
              const SizedBox(height: 20),

              CustomTextAlignment(text: 'Password'),
              const SizedBox(height: 8),

              Obx(
                    () => CustomTextField(
                  controller: controller.passwordController,
                  obscureText: !controller.showPassword.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.showPassword.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: controller.togglePassword,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Obx(
                    () => GestureDetector(
                  onTap:
                  controller.isLoading.value ? null : () => controller.login(),

                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: controller.isLoading.value
                          ? Colors.grey
                          : Colors.black,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      )
                          : const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: Colors.black26, width: 1.3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AssetsManager.Googlelogo, width: 25),
                    const SizedBox(width: 10),
                    const Text(
                      "Login with Google",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              TextButton(
                onPressed: () => Get.to(ForgotPasswordScreen()),
                child: const Text(
                  "forgot password ?",
                  style: TextStyle(color: Colors.red),
                ),
              ),

              InkWell(
                onTap: () => Get.toNamed(Road.register),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("don't have an account? "),
                    Text("create", style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
