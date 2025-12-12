import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:news_depi_final_project/core/constants/api_endpoints.dart';
import '../model/GnewsModel.dart';
import '../model/NewsApiModel.dart';

class NewsService extends GetxService {
  final String newsAPIKey = '2528ed953bb247ccbe11c1cc63afb51c';
  final String gNewsKey = 'b626a87f91cda2579ba73078032db27f';
  final Dio dio = Dio();
  final cancelToken = CancelToken();

  void cancel() {
    if (!cancelToken.isCancelled) {
      cancelToken.cancel();
    }
  }

  Future<NewsApiModel?> getNewsFromNewsAPI(String query) async {
    try {
      final response = await dio.get(
        ApiEndpoints.newsApiBase,
        queryParameters: {
          'q': query,
          'apiKey': newsAPIKey,
          'language': 'en',
          'sortBy': 'publishedAt',
        },
        cancelToken: cancelToken,
      );

      if (response.statusCode == 200 && response.data != null) {
        return NewsApiModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print("NewsAPI error: $e");
      return null;
    }
  }

  Future<List<String>> fetchCategories() async {
    try {
      final response = await dio.get(
        ApiEndpoints.newsApiSources,
        queryParameters: {'apiKey': newsAPIKey, 'language': 'en'},
      );

      if (response.statusCode == 200) {
        final sources = response.data['sources'] as List<dynamic>;

        final categories = sources
            .map((s) => s['category'].toString())
            .toSet()
            .toList();
        print("$categories");
        return categories;
      }

      return [];
    } catch (e) {
      print("Category API error: $e");
      return [];
    }
  }

  // 3. GNews
  Future<GnewsModel?> getNewsFromGNews(String query) async {
    try {
      final response = await dio.get(
        ApiEndpoints.gNewsBase,
        queryParameters: {
          'q': query,
          'token': gNewsKey,
          'lang': 'en',
          'max': 10,
        },
        cancelToken: cancelToken,
      );

      if (response.statusCode == 200 && response.data != null) {
        return GnewsModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print("GNews error: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>> getCombinedNews(String query) async {
    final results = await Future.wait([
      getNewsFromNewsAPI(query),
      getNewsFromGNews(query),
    ]);

    return {'newsApi': results[0], 'gnews': results[1]};
  }

  Future<bool> hasNewUpdates(String topic, DateTime lastChecked) async {
    try {
      final combinedData = await getCombinedNews(topic);

      final newsApiArticles =
          (combinedData['newsApi'] as NewsApiModel?)?.articles ?? [];
      for (var article in newsApiArticles) {
        if (article.publishedAt != null &&
            article.publishedAt!.isAfter(lastChecked)) {
          return true;
        }
      }

      // Check GNews articles
      final gnewsArticles =
          (combinedData['gnews'] as GnewsModel?)?.articles ?? [];
      for (var article in gnewsArticles) {
        if (article.publishedAt.isAfter(lastChecked)) {
          return true;
        }
      }
      return false;
    } catch (e) {
      print("Error checking updates: $e");
      return false;
    }
  }

  @override
  void onClose() {
    cancel();
    super.onClose();
  }
}
