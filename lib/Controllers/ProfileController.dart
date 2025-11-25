import 'package:get/get.dart';
import 'package:news_depi_final_project/Models/UserModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../Services/AuthService.dart';

class Profilecontroller extends GetxController {
  final supabase = Supabase.instance.client;

  RxString email = ''.obs;
  RxString username = ''.obs;
  RxBool loading = true.obs;
  Rx<XFile?> pickedImage = Rx<XFile?>(null);
  final Rxn<UserModel> userData = Rxn<UserModel>();
  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final user = await AuthService().loadUser();
    userData.value = user;
    print(userData.value?.username);
  }

  void logout(){
    AuthService().logout();
  }

  void setImage(XFile file) {
    pickedImage.value = file;
  }
}
