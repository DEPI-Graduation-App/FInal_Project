import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../home/data/model/category_model.dart';

class FavoritesController extends GetxController {
  final GetStorage _storage = GetStorage();
  final RxList<Category> favoriteItems = <Category>[].obs;
  final RxBool isFavoriteIcon = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  void loadFavorites() {
    try {
      final List<dynamic>? stored = _storage.read('favorites');
      if (stored != null) {
        favoriteItems.value = stored
            .map((json) => Category.fromJson(json))
            .toList();
      }
    } catch (e) {
      print('Error loading favorites: $e');
    }
  }

  void saveFavorites() {
    try {
      final List<Map<String, dynamic>> jsonList =
      favoriteItems.map((cat) => cat.toJson()).toList();
      _storage.write('favorites', jsonList);
    } catch (e) {
      print('Error saving favorites: $e');
    }
  }

  void toggleFavorite(Category item) {
    if (isFavorite(item)) {
      removeFromFavorites(item);
    } else {
      addToFavorites(item);
    }
    print(favoriteItems);
  }

  void toggleFavoriteIcon(String title) {
    isFavoriteIcon.value = !isFavoriteIcon.value;
    Get.snackbar(
      isFavoriteIcon.value ? "Added to Favorites" : "Removed from Favorites",
      title,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      backgroundColor: isFavoriteIcon.value ? Colors.green : Colors.red,
    );
  }

  void addToFavorites(Category item) {
    if (!isFavorite(item)) {
      favoriteItems.add(item);
      saveFavorites();
    }
  }

  void removeFromFavorites(Category item) {
    favoriteItems.removeWhere((cat) => cat.id == item.id);
    saveFavorites();
  }

  bool isFavorite(Category item) {
    return favoriteItems.any((cat) => cat.id == item.id);
  }
}