import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../Management/ApiEndPoints.dart';
import '../Models/News_Models/CurrentsNewsModel.dart';
import '../Models/News_Models/GnewsModel.dart';
import '../Models/News_Models/NewsApiModel.dart';

class NewsService extends GetxService {
  final String newsAPIKey = 'c7edb54fa7e24e58b11df93744ea9d9e';
  final String gNewsKey = 'b626a87f91cda2579ba73078032db27f';
  final String currentNewsKey = 'qDUdQd7Vi2YCV-yIL0WR9Yo9lcO_WSdX-Ulc19lwjFpLiR24';

  final Dio dio = Dio();
  final cancelToken = CancelToken();

  void cancel() {
    cancelToken.cancel();
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
        queryParameters: {
          'apiKey': newsAPIKey,
          'language': 'en',
        },
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

  Future<CurrentsNewsModel?> getNewsFromCurrents(String query) async {
    try {
      final response = await dio.get(
        ApiEndpoints.currentsNewsBase,
        queryParameters: {
          'keywords': query,
          'language': 'en',
        },
        options: Options(
          headers: {
            'Authorization': currentNewsKey,
          },
        ),
        cancelToken: cancelToken,
      );

      if (response.statusCode == 200 && response.data != null) {
        return CurrentsNewsModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print("CurrentsAPI error: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>> getCombinedNews(String query) async {
    final results = await Future.wait([
      getNewsFromNewsAPI(query),
      getNewsFromGNews(query),
      getNewsFromCurrents(query),
    ]);

    return {
      'newsApi': results[0],
      'gnews': results[1],
      'currents': results[2],
    };
  }

  Future<bool> hasNewUpdates(String topic, DateTime lastChecked) async {
    try {
      final combinedData = await getCombinedNews(topic);

      // Check NewsAPI articles
      final newsApiArticles = combinedData['newsApi']?.articles ?? [];
      for (var article in newsApiArticles) {
        if (article.publishedAt.isAfter(lastChecked)) {
          return true;
        }
      }

      // Check GNews articles
      final gnewsArticles = combinedData['gnews']?.articles ?? [];
      for (var article in gnewsArticles) {
        if (article.publishedAt.isAfter(lastChecked)) {
          return true;
        }
      }

      // Check Currents news
      final currentsNews = combinedData['currents']?.news ?? [];
      for (var news in currentsNews) {
        try {
          final publishedAt = DateTime.parse(news.published);
          if (publishedAt.isAfter(lastChecked)) {
            return true;
          }
        } catch (e) {
          print("Error parsing date: ${news.published}");
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