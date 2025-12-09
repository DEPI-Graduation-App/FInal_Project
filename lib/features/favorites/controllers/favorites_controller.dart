import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_depi_final_project/generated/l10n.dart';
import '../../Notifications/notification_service.dart';
import '../../auth/data/model/UserModel.dart';
import '../../auth/data/services/AuthService.dart';
import '../../home/data/model/category_model.dart';
import '../../news/data/Services/NewsService.dart';

class FavoritesController extends GetxController {
  final NewsService newsService = Get.find<NewsService>();
  final GetStorage _storage = GetStorage();

  final RxList<Category> favoriteItems = <Category>[].obs;
  final RxBool loading = false.obs;
  final Rxn<UserModel> userData = Rxn<UserModel>();
  RxString userId = ''.obs;

  Timer? _newsTimer;
  bool _isCheckingNews = false;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();

    // Poll every 1 minute
    _newsTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      checkForNewFavoriteNews();
    });
  }

  @override
  void onClose() {
    _newsTimer?.cancel();
    super.onClose();
  }

  /// -------------------- Notifications Logic --------------------

  Future<void> checkForNewFavoriteNews() async {
    if (_isCheckingNews) return;
    if (favoriteItems.isEmpty) return;

    // Check connectivity
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) return;

    _isCheckingNews = true;

    try {
      for (final category in favoriteItems) {
        final combined = await newsService.getCombinedNews(category.name);

        final newsApiArticles = combined['newsApi']?.articles ?? [];
        final gnewsArticles = combined['gnews']?.articles ?? [];

        final newArticles = [
          ...newsApiArticles,
          ...gnewsArticles,
        ].where((a) => !_alreadyNotified(a.title ?? '')).toList();

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

  // Track notified articles
  bool _alreadyNotified(String title) {
    final list =
        _storage.read('notified_${userId.value}')?.cast<String>() ?? [];
    return list.contains(title);
  }

  void _markAsNotified(String title) {
    final list =
        _storage.read('notified_${userId.value}')?.cast<String>() ?? [];
    list.add(title);
    _storage.write('notified_${userId.value}', list);
  }

  /// -------------------- User & Favorites --------------------

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
    final data = _storage.read('favorites_${userId.value}');
    if (data != null) {
      favoriteItems.value =
          (data as List).map((e) => Category.fromJson(e)).toList();
    }
  }

  void saveFavorites() {
    final list = favoriteItems.map((e) => e.toJson()).toList();
    _storage.write('favorites_${userId.value}', list);
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
      );
      saveFavorites();
    }
  }

  void removeFromFavorites(Category item, String title) {
    favoriteItems.removeWhere((cat) => cat.id == item.id);
    Get.snackbar(
      S.current.removed,
      S.current.categoryRemovedFromFavorites(title),
    );
    saveFavorites();
  }

  bool isFavorite(Category item) {
    return favoriteItems.any((cat) => cat.id == item.id);
  }
}
