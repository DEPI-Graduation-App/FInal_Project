import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:news_depi_final_project/core/routes/app_pages.dart';
import 'package:news_depi_final_project/features/news/data/Services/NewsService.dart';

import 'package:news_depi_final_project/features/gemini/data/datasources/gemini_remote_datasource.dart';
import 'package:news_depi_final_project/features/gemini/domain/repositories/i_gemini_repository.dart';
import 'package:news_depi_final_project/features/gemini/data/repositories/gemini_repository_impl.dart'; // افترضنا وجود الـ Impl هنا
import 'package:news_depi_final_project/features/gemini/domain/usecases/get_ai_summary_usecase.dart';

import 'package:news_depi_final_project/features/news/data/model/NewsApiModel.dart'
    as news_api;
import 'package:news_depi_final_project/features/news/data/model/GnewsModel.dart'
    as g_news;
import 'package:vibration/vibration.dart';
import '../../news/data/model/article.dart';

class AiBriefingController extends GetxController {
  final NewsService newsService;

  AiBriefingController({required this.newsService});

  final RxMap<String, Article> cachedSummaries = <String, Article>{}.obs;
  final RxSet<String> loadingTopicIds = <String>{}.obs;

  List<Map<String, String>> get staticTopics => [
    {
      'label': 'General',
      'value': 'general',
      'image': 'assets/images/general.png',
    },
    {'label': 'Sports', 'value': 'sports', 'image': 'assets/images/Sports.png'},
    {
      'label': 'Technology',
      'value': 'technology',
      'image': 'assets/images/Technology.png',
    },
    {
      'label': 'Business',
      'value': 'business',
      'image': 'assets/images/Business.png',
    },
    {'label': 'Health', 'value': 'health', 'image': 'assets/images/Health.png'},
    {
      'label': 'Science',
      'value': 'science',
      'image': 'assets/images/Science.png',
    },
  ];

  // ==================================================
  //  MANUAL DEPENDENCY INJECTION
  // ==================================================
  void _initGeminiModule() {
    if (!Get.isRegistered<GetAiSummaryUseCase>()) {
      print(" Initializing Gemini Module on Demand...");

      Get.put<IGeminiRemoteDataSource>(
        GeminiRemoteDataSourceImpl(Gemini.instance),
      );
      Get.put<IGeminiRepository>(
        GeminiRepositoryImpl(Get.find<IGeminiRemoteDataSource>()),
      );
      Get.put<GetAiSummaryUseCase>(
        GetAiSummaryUseCase(Get.find<IGeminiRepository>()),
      );
    }
  }

  // ==================================================
  //  Main Logic
  // ==================================================
  Future<void> selectAndSummarizeTopic(
    Map<String, String> topic, {
    bool forceRefresh = false,
  }) async {
    final topicId = topic['value']!;

    if (loadingTopicIds.contains(topicId)) return;

    final cachedArticle = cachedSummaries[topicId];
    if (!forceRefresh && cachedArticle != null) {
      _navigateToDetails(cachedArticle);
      return;
    }

    _initGeminiModule();

    loadingTopicIds.add(topicId);

    try {
      final Article result = await _fetchAndSummarizeTopic(topic);

      cachedSummaries[topicId] = result;
      loadingTopicIds.remove(topicId);
      Vibration.vibrate(duration: 400);

      Get.snackbar(
        "Your briefing is read",
        "${topic['label']} summary is ready",
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
        duration: const Duration(seconds: 3),
      );

      // _navigateToDetails(result);
    } catch (e) {
      loadingTopicIds.remove(topicId);
      print("ERROR: $e");
      Get.snackbar("Error", "Failed to generate summary: $e");
    }
  }

  void _navigateToDetails(Article fullArticle) {
    Get.toNamed(AppPages.articleDetailsPage, arguments: fullArticle);
  }

  Future<Article> _fetchAndSummarizeTopic(Map<String, String> topic) async {
    final label = topic['label']!;
    final value = topic['value']!;
    final fixedImage = topic['image']!;

    String summaryText = "";
    String articleUrl = "https://news.google.com";

    try {
      final Map<String, dynamic> rawData = await newsService.getCombinedNews(
        value,
      );
      List<Article> unifiedList = _mapRawDataToArticles(rawData);

      if (unifiedList.isNotEmpty) {
        articleUrl = unifiedList.first.articleUrl;
        final useCase = Get.find<GetAiSummaryUseCase>();

        summaryText = await useCase.call(
          topic: label,
          articles: unifiedList.take(20).toList(),
        );
      } else {
        summaryText = "No recent articles found regarding this topic.";
      }
    } catch (e) {
      print("Error inside fetch: $e");
      summaryText = "An error occurred while analyzing news.";
    }

    return Article(
      id: value,
      sourceName: "AI Briefing",
      title: "Briefing: $label",
      description: summaryText,
      articleUrl: articleUrl,
      imageUrl: fixedImage,
      publishedAt: DateTime.now(),
      author: "Gemini AI",
      content: summaryText,
    );
  }

  // ... (Mapping Function Remains the same)
  List<Article> _mapRawDataToArticles(Map<String, dynamic> rawData) {
    List<Article> list = [];
    if (rawData['newsApi'] != null) {
      final data = rawData['newsApi'] as news_api.NewsApiModel;
      for (var item in data.articles) {
        list.add(
          Article(
            id: item.url ?? DateTime.now().toString(),
            sourceName: item.source?.name ?? "NewsAPI",
            title: item.title ?? "No Title",
            description: item.description,
            articleUrl: item.url ?? "",
            imageUrl: item.urlToImage,
            publishedAt: item.publishedAt ?? DateTime.now(),
            author: item.author,
          ),
        );
      }
    }
    if (rawData['gnews'] != null) {
      final data = rawData['gnews'] as g_news.GnewsModel;
      for (var item in data.articles) {
        list.add(
          Article(
            id: item.url,
            sourceName: item.source.name,
            title: item.title,
            description: item.description,
            articleUrl: item.url,
            imageUrl: item.image,
            publishedAt: item.publishedAt,
            author: "GNews Source",
          ),
        );
      }
    }
    return list;
  }
}
