import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_depi_final_project/generated/l10n.dart';
import '../../Notifications/notification_service.dart';
import '../../auth/data/model/UserModel.dart';
import '../../auth/data/services/AuthService.dart';
import '../../home/data/model/category_model.dart';
import '../../news/data/Services/NewsService.dart';

class FavoritesController extends GetxController {
  // Dependencies
  final NewsService newsService = Get.find<NewsService>();
  final GetStorage _storage = GetStorage();

  // State
  final RxList<Category> favoriteItems = <Category>[].obs;
  final RxBool isFavoriteIcon = false.obs;
  RxString userId = ''.obs;
  RxBool loading = false.obs;
  final Rxn<UserModel> userData = Rxn<UserModel>();

  // Timer & API lock
  Timer? _newsTimer;
  bool _isCheckingNews = false;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();

    /// Start periodic news check every 1 minute
    _newsTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      checkForNewFavoriteNews();
    });
  }

  @override
  void onClose() {
    _newsTimer?.cancel();
    super.onClose();
  }

  /// Fetch news for favorite categories and show notifications for new articles
  Future<void> checkForNewFavoriteNews() async {
    if (_isCheckingNews) return; // skip if previous check is still running
    if (favoriteItems.isEmpty) return;

    _isCheckingNews = true;

    try {
      for (final category in favoriteItems) {
        final combined = await newsService.getCombinedNews(category.name);
        final newsApiArticles = combined['newsApi']?.articles ?? [];
        final gnewsArticles = combined['gnews']?.articles ?? [];

        final newArticles = [
          ...newsApiArticles,
          ...gnewsArticles,
        ].where((article) => !_alreadyNotified(article.title ?? '')).toList();

        for (final article in newArticles) {
          NotificationService.showNotification(
            title: category.name,
            body: article.title ?? 'New article available',
          );
          _markAsNotified(article.title ?? '');
        }
      }
    } catch (e) {
      print("Error checking favorite news: $e");
    } finally {
      _isCheckingNews = false;
    }
  }

  /// -------------------- User Data & Favorites --------------------

  Future<void> fetchUserData() async {
    loading.value = true;

    final user = await AuthService().loadUser();
    if (user != null) {
      userData.value = user;
      userId.value = user.id;
      loadFavorites();
    }

    loading.value = false;
  }

  void loadFavorites() {
    if (userId.value.isEmpty) return;

    try {
      final List<dynamic>? stored = _storage.read('favorites_${userId.value}');
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
    if (userId.value.isEmpty) return;

    try {
      final jsonList = favoriteItems.map((cat) => cat.toJson()).toList();
      _storage.write('favorites_${userId.value}', jsonList);
    } catch (e) {
      print('Error saving favorites: $e');
    }
  }

  void toggleFavorite(Category item, String title) {
    if (isFavorite(item)) {
      removeFromFavorites(item, title);
    } else {
      addToFavorites(item, title);
    }
  }

  void addToFavorites(Category item, String title) {
    if (!isFavorite(item)) {
      favoriteItems.add(item);
      Get.snackbar(
        S.current.added,
        S.current.categoryAddedToFavorites(title),
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
      );
      saveFavorites();
    }
  }

  void removeFromFavorites(Category item, String title) {
    favoriteItems.removeWhere((cat) => cat.id == item.id);
    Get.snackbar(
      S.current.removed,
      S.current.categoryRemovedFromFavorites(title),
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.red,
    );
    saveFavorites();
  }

  bool isFavorite(Category item) {
    return favoriteItems.any((cat) => cat.id == item.id);
  }

  /// -------------------- Notification Tracking --------------------

  bool _alreadyNotified(String title) {
    final notified =
        _storage.read<List<String>>('notified_${userId.value}') ?? [];
    return notified.contains(title);
  }

  void _markAsNotified(String title) {
    final notified =
        _storage.read<List<String>>('notified_${userId.value}') ?? [];
    notified.add(title);
    _storage.write('notified_${userId.value}', notified);
  }
}
