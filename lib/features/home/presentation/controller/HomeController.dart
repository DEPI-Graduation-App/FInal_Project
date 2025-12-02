// lib/Controllers/HomeController.dart
import 'package:get/get.dart';
import 'package:news_depi_final_project/core/routes/app_pages.dart';
import '../../../news/pages/SelectedNewsScreen.dart';
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

  Future<void> onCategoryTap(Category category, int index) async {
    try {
      Get.toNamed( AppPages.SelectedNews, arguments: [category.name,category]);
    } catch (e) {
      errorMessage.value = 'Failed to load news for ${category.name}';
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
