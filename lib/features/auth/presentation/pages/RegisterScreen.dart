import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_depi_final_project/core/constants/assets_manager.dart';
import 'package:news_depi_final_project/features/auth/presentation/widgets/BuildTextField.dart';
import 'package:news_depi_final_project/features/auth/presentation/widgets/CustomTextAlignment.dart';
import 'package:news_depi_final_project/features/auth/presentation/pages/LoginScreen.dart';
import 'package:news_depi_final_project/generated/l10n.dart';
import '../controller/RegisterController.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(S.of(context).register,style: TextStyle(color: Color(0xFFD62828)),),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Image.asset(AssetsManager.logo, width: 300, height: 140),

            Text(
              S.of(context).WelcomeToApp,
              style: const TextStyle(
                color: Color(0xFFD62828),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Divider(),
            const SizedBox(height: 10),

            CustomTextAlignment(text: S.of(context).emailAddress),
            const SizedBox(height: 8),
            CustomTextField(
              controller: controller.EmailController,
              keyboardType: TextInputType.emailAddress,
              hint: S.of(context).enterEmail,
            ),
            const SizedBox(height: 20),

            CustomTextAlignment(text: S.of(context).username),
            const SizedBox(height: 8),
            CustomTextField(
              controller: controller.UsernameController,
              hint: S.of(context).enterUsername,
            ),
            const SizedBox(height: 20),

            CustomTextAlignment(text: S.of(context).password),
            const SizedBox(height: 8),
            Obx(
              () => CustomTextField(
                controller: controller.PasswordController,
                obscureText: !controller.showPassword.value,
                hint: S.of(context).enterPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.showPassword.value
                        ? Icons.visibility
                        : Icons.visibility_off,

                    color: Color(0xFFD62828),
                  ),
                  onPressed: controller.togglePassword,
                ),
              ),
            ),
            const SizedBox(height: 20),

            CustomTextAlignment(text: S.of(context).confirmPassword),
            const SizedBox(height: 8),
            Obx(
              () => CustomTextField(
                controller: controller.RepasswordController,
                obscureText: !controller.showRePassword.value,
                hint: S.of(context).reEnterPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.showRePassword.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Color(0xFFD62828),
                  ),
                  onPressed: controller.toggleRePassword,
                ),
              ),
            ),
            const SizedBox(height: 30),

            Obx(
              () => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: controller.register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFD62828),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 120,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(S.of(context).register),
                    ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () => Get.off(LoginScreen()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).alreadyHaveAccount),
                  Text(
                    S.of(context).login,
                    style: const TextStyle(color: Colors.red),
                  ),
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
