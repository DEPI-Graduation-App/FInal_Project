import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../Management/ApiEndPoints.dart';
import '../Models/News_Models/CurrentsNewsModel.dart';
import '../Models/News_Models/GnewsModel.dart';
import '../Models/News_Models/NewsApiModel.dart' hide Article;


class NewsService extends GetxService {
  final Dio dio = Dio();

  final NewsAPIKey = 'c7edb54fa7e24e58b11df93744ea9d9e';
  final GNewsKEY = 'b626a87f91cda2579ba73078032db27f';
  final CurrentNewsKey = 'qDUdQd7Vi2YCV-yIL0WR9Yo9lcO_WSdX-Ulc19lwjFpLiR24';

  Future<NewsApiModel?> getNewsFromNewsAPI(String query) async {
    try {
      final response = await dio.get(
        ApiEndpoints.newsApiBase,
        queryParameters: {
          'q': query,
          'apiKey': NewsAPIKey,
          'language': 'en',
        },
      );
      return NewsApiModel.fromJson(response.data);
    } catch (e) {
      print("NewsAPI error: $e");
      return null;
    }
  }

  Future<GnewsModel?> getNewsFromGNews(String query) async {
    try {
      final response = await dio.get(
        ApiEndpoints.gNewsBase,
        queryParameters: {
          'q': query,
          'token': GNewsKEY,
          'lang': 'en',
        },
      );
      return GnewsModel.fromJson(response.data);
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
          'apiKey': CurrentNewsKey,
        },
      );
      return CurrentsNewsModel.fromJson(response.data);
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
    final combinedData = await getCombinedNews(topic);
    final allArticles = [
      ...?combinedData['newsApi']?.articles,
      ...?combinedData['gnews']?.articles,
      ...?combinedData['currents']?.news,
    ];

    // Check if any article is newer than last check
    return allArticles.any((news) {
      final date = news is Article ? news.publishedAt : DateTime.parse(news.published);
      return date.isAfter(lastChecked);
    });
  }
}
