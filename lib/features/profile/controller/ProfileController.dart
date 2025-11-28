import 'package:get/get.dart';
import 'package:news_depi_final_project/core/routes/app_pages.dart';
import 'package:news_depi_final_project/features/auth/data/model/UserModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../auth/data/services/AuthService.dart';

class Profilecontroller extends GetxController {
  final supabase = Supabase.instance.client;

  RxString email = ''.obs;
  RxString username = ''.obs;
  RxBool loading = true.obs;
  Rx<XFile?> pickedImage = Rx<XFile?>(null);
  final ImagePicker picker = ImagePicker();
  final currentNavIndex = 0.obs;

  final Rxn<UserModel> userData = Rxn<UserModel>();
  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final user = await AuthService().loadUser();

    if (user == null) return;

    userData.value = user;
    username.value = user.username;
    email.value = user.email;
  }

  Future<void> logout() async {
    await AuthService().logout();
    Get.offAll(AppPages.loginPage);
  }

  void setImage(XFile file) {
    pickedImage.value = file;
  }
}
