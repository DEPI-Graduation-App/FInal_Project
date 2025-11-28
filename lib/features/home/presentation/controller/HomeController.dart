// lib/Controllers/HomeController.dart
import 'package:get/get.dart';
import '../../data/model/category_model.dart';
import '../../../news/data/Services/NewsService.dart';

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
      final categoryNames = await newsService.fetchCategories();

      if (categoryNames.isEmpty) {
        errorMessage.value = 'No categories available';
        return;
      }
      print("$categoryNames");

      categories.value = categoryNames.map((name) {
        return Category(
          id: name,
          name: name.capitalizeFirst!,
          icon: _categoryIcon(name),
        );
      }).toList();
    } catch (e) {
      errorMessage.value = 'Failed to load categories';
    } finally {
      isLoading.value = false;
    }
  }

  //  Removed the line that crashed the app
  Future<void> onCategoryTap(Category category, int index) async {
    // currentNavIndex.value = index;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final combined = await newsService.getCombinedNews(category.name);
      // Get.toNamed(
      //   '/category',
      //   arguments: {'category': category, 'news': combined},
      // );
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

String _categoryIcon(String name) {
  final icons = {
    'business': '💼',
    'entertainment': '🎬',
    'general': '📰',
    'health': '🩺',
    'science': '🔬',
    'sports': '🏅',
    'technology': '💻',
  };

  return icons[name] ?? '📰';
}
