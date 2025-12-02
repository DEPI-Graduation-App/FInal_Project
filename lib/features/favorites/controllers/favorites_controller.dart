import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../auth/data/model/UserModel.dart';
import '../../auth/data/services/AuthService.dart';
import '../../home/data/model/category_model.dart';

class FavoritesController extends GetxController {
  final GetStorage _storage = GetStorage();
  final RxList<Category> favoriteItems = <Category>[].obs;
  final RxBool isFavoriteIcon = false.obs;
  RxString username = ''.obs;
  RxBool loading = false.obs;
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
      loadFavorites();
    }

    loading.value = false;
  }


  void loadFavorites() {
    if (username.value.isEmpty) return;
    try {
      final List<dynamic>? stored =
      _storage.read('favorites_${username.value}');

      if (stored != null) {
        favoriteItems.value =
            stored.map((json) => Category.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error loading favorites: $e');
    }
  }


  void saveFavorites() {
    if (username.value.isEmpty) return;

    try {
      final jsonList =
      favoriteItems.map((cat) => cat.toJson()).toList();

      _storage.write('favorites_${username.value}', jsonList);
    } catch (e) {
      print('Error saving favorites: $e');
    }
  }



  void toggleFavorite(Category item,String title) {

    if (isFavorite(item)) {
      removeFromFavorites(item,title);
    } else {
      addToFavorites(item,title);
    }
  }



  void addToFavorites(Category item, String title) {

    if (!isFavorite(item)) {

      favoriteItems.add(item);
      Get.snackbar(
        "Added",
        "Category $title added to Favorites",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
      );
      saveFavorites();
    }
  }

  void removeFromFavorites(Category item,String title) {
    favoriteItems.removeWhere((cat) => cat.id == item.id);
    Get.snackbar(
      "Removed",
      "Category $title removed from Favorites",
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.red,
    );
    saveFavorites();
  }

  bool isFavorite(Category item) {
    return favoriteItems.any((cat) => cat.id == item.id);
  }
}
