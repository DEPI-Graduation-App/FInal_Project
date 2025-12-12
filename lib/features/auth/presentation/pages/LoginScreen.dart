import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        
        title: Text("Login",style: TextStyle(color: Color(0xFFD62828)),),
      ),
    //  backgroundColor: const Color(0xFF0A1A2F),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [

              Image.asset(
                AssetsManager.logo,
                width: 300,
                height: 140,
                fit: BoxFit.contain,
              ),

              Text(
                S.of(context).WelcomeToApp,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD62828),
                ),
              ),

              const Divider(),
              const SizedBox(height: 30),

              CustomTextAlignment(text: S.of(context).emailAddress,
              ),
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
                      color: Color(0xFFD62828),
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
                          ? Colors.white
                          :     Color(0xFFD62828),

                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(
                              strokeWidth: 2,
                        color: Color(0xFFD62828),                            )
                          : Text(
                              S.of(context).login,
                              style: const TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              InkWell(
                onTap: () => Get.offAllNamed(AppPages.registerPage),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(S.of(context).dontHaveAccount,
                      style:TextStyle(
                        color: Colors.white,
                      )
                    ),
                    Text(
                      S.of(context).create,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),

               SizedBox(height: 200,child: Image.asset(AssetsManager.slogan),),
            ],
          ),
        ),
      ),
    );
  }
}
