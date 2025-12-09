import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:news_depi_final_project/core/routes/app_pages.dart';
import 'package:news_depi_final_project/features/news/data/Services/NewsService.dart';
import 'package:news_depi_final_project/generated/l10n.dart';
import 'package:news_depi_final_project/features/gemini/data/datasources/gemini_remote_datasource.dart';
import 'package:news_depi_final_project/features/gemini/domain/repositories/i_gemini_repository.dart';
import 'package:news_depi_final_project/features/gemini/data/repositories/gemini_repository_impl.dart';
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
      'label': S.current.general,
      'value': 'general',
      'image': 'assets/images/general.png',
    },
    {
      'label': S.current.sports,
      'value': 'sports',
      'image': 'assets/images/Sports.png',
    },
    {
      'label': S.current.technology,
      'value': 'technology',
      'image': 'assets/images/Technology.png',
    },
    {
      'label': S.current.business,
      'value': 'business',
      'image': 'assets/images/Business.png',
    },
    {
      'label': S.current.health,
      'value': 'health',
      'image': 'assets/images/Health.png',
    },
    {
      'label': S.current.science,
      'value': 'science',
      'image': 'assets/images/Science.png',
    },
  ];

  void _initGeminiModule() {
    if (!Get.isRegistered<GetAiSummaryUseCase>()) {
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
        S.current.briefingReady,
        S.current.briefingTitle(topic['label']!),
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      loadingTopicIds.remove(topicId);
      Get.snackbar(S.current.error, S.current.errorAnalyzingNews);
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
    String contentEn = "";
    String contentAr = "";
    List<ArticleSource> sources = [];
    String articleUrl = "https://news.google.com";

    try {
      final Map<String, dynamic> rawData = await newsService.getCombinedNews(
        value,
      );
      List<Article> unifiedList = _mapRawDataToArticles(rawData);

      final now = DateTime.now();
      final yesterday = now.subtract(const Duration(hours: 24));

      var recentList = unifiedList.where((article) {
        return article.publishedAt.isAfter(yesterday);
      }).toList();

      if (recentList.isEmpty && unifiedList.isNotEmpty) {
        recentList = unifiedList;
      }

      if (recentList.isNotEmpty) {
        articleUrl = recentList.first.articleUrl;
        final useCase = Get.find<GetAiSummaryUseCase>();

        final topArticles = recentList.take(5).toList();
        sources = topArticles
            .map((a) => ArticleSource(name: a.sourceName, url: a.articleUrl))
            .toList();

        final fullResponse = await useCase.callDualLang(
          topic: label,
          articles: recentList.take(20).toList(),
        );

        const separator = "###SPLIT###";
        if (fullResponse.contains(separator)) {
          final parts = fullResponse.split(separator);
          contentEn = parts[0].trim();
          contentAr = parts.length > 1 ? parts[1].trim() : "";
          summaryText = contentEn;
        } else {
          summaryText = fullResponse;
          contentEn = fullResponse;
          contentAr = "";
        }
      } else {
        summaryText = S.current.noRecentArticles;
        contentEn = summaryText;
        contentAr = summaryText;
      }
    } catch (e) {
      summaryText = S.current.errorAnalyzingNews;
      contentEn = summaryText;
      contentAr = summaryText;
    }

    return Article(
      id: value,
      sourceName: S.current.aiBriefingSource,
      title: S.current.briefingTitle(label),
      description: summaryText,
      articleUrl: articleUrl,
      imageUrl: fixedImage,
      publishedAt: DateTime.now(),
      author: S.current.geminiAiAuthor,
      content: summaryText,
      contentEn: contentEn,
      contentAr: contentAr,
      sources: sources,
      isAiGenerated: true,
    );
  }

  List<Article> _mapRawDataToArticles(Map<String, dynamic> rawData) {
    List<Article> list = [];

    if (rawData['newsApi'] != null) {
      final data = rawData['newsApi'] as news_api.NewsApiModel;
      for (var item in data.articles) {
        list.add(
          Article(
            id: item.url ?? DateTime.now().toString(),
            sourceName: item.source?.name ?? S.current.newsApiSource,
            title: item.title ?? S.current.noTitle,
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
            author: S.current.gnewsSource,
          ),
        );
      }
    }
    return list;
  }
}
