import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_depi_final_project/core/routes/app_pages.dart';
import 'package:news_depi_final_project/generated/l10n.dart';

import '../controller/LoginController.dart';
import '../widgets/BuildTextField.dart';
import '../../../../core/constants/assets_manager.dart';
import '../widgets/CustomTextAlignment.dart';

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

              Text(
                S.of(context).welcomeToApp,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff47515b),
                ),
              ),

              const Divider(),
              const SizedBox(height: 30),

              CustomTextAlignment(text: S.of(context).emailAddress),
              const SizedBox(height: 8),
              CustomTextField(controller: controller.usernameController),
              const SizedBox(height: 20),

              CustomTextAlignment(text: S.of(context).password),
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
                  onTap: () async {
                    if (controller.isLoading.value) return;
                    bool success = await controller.login();
                    if (success) {
                      Future.delayed(const Duration(milliseconds: 100), () {
                        Get.offAllNamed(AppPages.layout);
                      });
                    }
                  },

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
                          : Text(
                              S.of(context).login,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              InkWell(
                onTap: () => Get.toNamed(AppPages.registerPage),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(S.of(context).dontHaveAccount),
                    Text(
                      S.of(context).create,
                      style: const TextStyle(color: Colors.red),
                    ),
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
