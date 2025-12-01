import 'package:get/get.dart';
import '../data/Services/NewsService.dart';
import '../data/model/GnewsModel.dart';
import '../data/model/NewsApiModel.dart';

class SelectedNewsController extends GetxController {
  final NewsService newsService = Get.find<NewsService>();
  RxBool isLoading = false.obs;
  RxList<Article> newsApiArticles = <Article>[].obs;
  RxList<GnewsArticle> gnewsArticles = <GnewsArticle>[].obs;

  Future<void> loadAllNews(String category) async {
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

    isLoading.value = true;

    final combined = await newsService.getCombinedNews(query);
    final newsApiModel = combined['newsApi'] as NewsApiModel?;
    final gnewsModel = combined['gnews'] as GnewsModel?;

    newsApiArticles.value = newsApiModel?.articles ?? [];
    gnewsArticles.value = gnewsModel?.articles ?? [];

    isLoading.value = false;
  }

}
