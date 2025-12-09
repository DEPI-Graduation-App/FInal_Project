import 'package:get/get.dart';
import '../../favorites/controllers/favorites_controller.dart';
import '../data/Services/NewsService.dart';
import '../data/model/GnewsModel.dart';
import '../data/model/NewsApiModel.dart';
import '../../briefing/controller/briefing_controller.dart';

class SelectedNewsController extends GetxController {
  final NewsService newsService = Get.find<NewsService>();
  final favController = Get.find<FavoritesController>();

  RxBool isLoading = false.obs;
  RxList<Article> newsApiArticles = <Article>[].obs;
  RxList<GnewsArticle> gnewsArticles = <GnewsArticle>[].obs;
  RxString currentTopic = ''.obs;
  RxBool isSearchMode = false.obs;

  Future<void> loadAllNews(String category) async {
    currentTopic.value = category;
    isSearchMode.value = false;
    isLoading.value = true;

    final combined = await newsService.getCombinedNews(category);
    final newsApiModel = combined['newsApi'] as NewsApiModel?;
    final gnewsModel = combined['gnews'] as GnewsModel?;

    newsApiArticles.value = newsApiModel?.articles ?? [];
    gnewsArticles.value = gnewsModel?.articles ?? [];

    isLoading.value = false;
  }

  Future<void> searchNews(String query) async {
    if (query.isEmpty) return;

    // Clear previous search from briefing cache if we were in search mode
    if (isSearchMode.value && currentTopic.value.isNotEmpty) {
      try {
        final briefingController = Get.find<AiBriefingController>();
        briefingController.cachedSummaries.remove(currentTopic.value);
      } catch (e) {
        // Controller might not be registered yet or other error, ignore
      }
    }

    currentTopic.value = query;
    isSearchMode.value = true;

    isLoading.value = true;

    final combined = await newsService.getCombinedNews(query);
    final newsApiModel = combined['newsApi'] as NewsApiModel?;
    final gnewsModel = combined['gnews'] as GnewsModel?;

    newsApiArticles.value = newsApiModel?.articles ?? [];
    gnewsArticles.value = gnewsModel?.articles ?? [];

    isLoading.value = false;
  }
}
