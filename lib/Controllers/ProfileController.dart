import 'package:get/get.dart';
import 'package:news_depi_final_project/Models/UserModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../Roads/road.dart';
import '../Services/AuthService.dart';

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
  void changeNavIndex(int index) {
    currentNavIndex.value = index;

    if (index == 0) Get.toNamed(Road.home);
    //if (index == 1) Get.toNamed(Road.);
    if (index == 2) Get.toNamed(Road.profile);
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
    Get.toNamed(Road.login);
  }

  void setImage(XFile file) {
    pickedImage.value = file;
  }
}
