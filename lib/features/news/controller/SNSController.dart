import 'package:get/get.dart';
import '../data/Services/NewsService.dart';
import '../data/model/CurrentsNewsModel.dart';
import '../data/model/GnewsModel.dart';
import '../data/model/NewsApiModel.dart' hide Article;
import '../data/model/article.dart';

class SelectedNewsController extends GetxController {
  final NewsService newsService = Get.find<NewsService>();

  RxBool isLoading = false.obs;

  RxList<Article> newsApiArticles = <Article>[].obs;
  RxList<GnewsArticle> gnewsArticles = <GnewsArticle>[].obs;
  RxList<News> currentsArticles = <News>[].obs;

  Future<void> loadAllNews(String category) async {
    isLoading.value = true;

    final combined = await newsService.getCombinedNews(category);

    final newsApiModel = combined['newsApi'] as NewsApiModel?;
    final gnewsModel = combined['gnews'] as GnewsModel?;
    final currentsModel = combined['currents'] as CurrentsNewsModel?;

    newsApiArticles.value = newsApiModel?.articles ?? [];
    gnewsArticles.value = gnewsModel?.articles ?? [];
    currentsArticles.value = currentsModel?.news ?? [];

    isLoading.value = false;
  }
}
