import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_depi_final_project/core/routes/app_pages.dart';
import 'package:news_depi_final_project/features/auth/data/model/UserModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../auth/data/services/AuthService.dart';
import '../../auth/data/services/SupaBaseServices.dart';

class Profilecontroller extends GetxController {

  RxString email = ''.obs;
  RxString username = ''.obs;
  RxBool loading = false.obs;
  Rx<XFile?> pickedImage = Rx<XFile?>(null);

  final ImagePicker picker = ImagePicker();

  final Rxn<UserModel> userData = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    loading.value = true;

    final user = await AuthService().loadUser();
    if (user != null) {
      userData.value = user;
      username.value = user.username;
      email.value = user.email;
    }

    loading.value = false;
  }

  Future<void> logout() async {
    await AuthService().logout();
    Get.offAllNamed(AppPages.loginPage);
  }

  void setImage(XFile file) async {
    pickedImage.value = file;

    final userId = userData.value?.id;
    if (userId == null) return;

    await pickAndUploadImage(userId);
  }


// inside Profilecontroller
  Future<void> pickAndUploadImage(String userId) async {
    if (pickedImage.value == null) return;

    File file = File(pickedImage.value!.path);
    final uploadedUrl = await SupaBaseServices().uploadProfilePic(file, userId);

    debugPrint('uploadedUrl -> $uploadedUrl');

    if (uploadedUrl == null) return;

    final updated = await SupaBaseServices().updateUserProfilePic(
        userId, uploadedUrl);

    debugPrint('updateUserProfilePic returned -> $updated');

    if (updated) {
      // Try to evict any cached image for that URL (best-effort)
      try {
        await NetworkImage(uploadedUrl).evict(
            configuration: const ImageConfiguration());
        // PaintingBinding.instance.imageCache.clear();
        debugPrint('Image evicted from cache for url -> $uploadedUrl');
      } catch (e) {
        debugPrint('Error evicting image cache: $e');
      }

      userData.value = userData.value!.copyWith(profilePic: uploadedUrl);
      userData.refresh();

      pickedImage.value = null;
      pickedImage.refresh();

      debugPrint(
          'userData.profilePic after update -> ${userData.value?.profilePic}');
    }
  }
}
