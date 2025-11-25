// lib/Controllers/HomeController.dart
import 'package:get/get.dart';
import '../Models/CategoryModel/category_model.dart';
import '../Services/NewsService.dart';

class HomeController extends GetxController {
  final NewsService newsService = Get.find<NewsService>();

  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final categories = <Category>[].obs;
  final currentNavIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void changeNavIndex(int index) {
    currentNavIndex.value = index;
  }

  Future<void> fetchCategories() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      // Provide a default set of categories to match the home screen layout.
      categories.value = [
        Category(id: 'sports', name: 'Sports'),
        Category(id: 'local', name: 'Local'),
        Category(id: 'general', name: 'General'),
        Category(id: 'tech', name: 'Technology'),
        Category(id: 'business', name: 'Business'),
        Category(id: 'health', name: 'Health'),
        Category(id: 'science', name: 'Science'),
        Category(id: 'entertainment', name: 'Entertainment'),
        Category(id: 'politics', name: 'Politics'),
      ];
    } catch (e) {
      errorMessage.value = 'Failed to load categories';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onCategoryTap(Category category, int index) async {
    currentNavIndex.value = index;
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final combined = await newsService.getCombinedNews(category.name);
      Get.toNamed('/category', arguments: {
        'category': category,
        'news': combined,
      });
    } catch (e) {
      errorMessage.value = 'Failed to load news for ${category.name}';
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> checkForUpdates(String topic, DateTime lastChecked) {
    return newsService.hasNewUpdates(topic, lastChecked);
  }
}
