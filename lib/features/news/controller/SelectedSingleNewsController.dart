import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/model/GnewsModel.dart';
import '../data/model/NewsApiModel.dart';
import 'SNSController.dart';

class SelectedSingleNewsController extends GetxController {
  late dynamic newsItem;
  RxList<dynamic> similarArticles = <dynamic>[].obs;

  @override
  void onInit() {
    // Retrieve passed article
    newsItem = Get.arguments;

    // Load similar news from existing SelectedNewsController
    try {
      final parentController = Get.find<SelectedNewsController>();

      final List<dynamic> allArticles = [
        ...parentController.gnewsArticles,
        ...parentController.newsApiArticles
      ];

      // Simple similarity logic: based on same first keyword
      String mainTitle = _getTitle(newsItem);
      String key = mainTitle.split(" ").first;

      similarArticles.value = allArticles
          .where((a) => a != newsItem && _getTitle(a).contains(key))
          .take(10)
          .toList();
    } catch (_) {
      similarArticles.clear();
    }
    super.onInit();
  }

  // Helper functions to avoid repeated checks
  String _getTitle(dynamic item) {
    if (item is Article) return item.title ?? '';
    if (item is GnewsArticle) return item.title;
    return '';
  }

  String? _getImage(dynamic item) {
    if (item is Article) return item.urlToImage;
    if (item is GnewsArticle) return item.image;
    return null;
  }

  String? _getDescription(dynamic item) {
    if (item is Article) return item.description;
    if (item is GnewsArticle) return item.content;
    return null;
  }

  String? _getLink(dynamic item) {
    if (item is Article) return item.url;
    if (item is GnewsArticle) return item.url;
    return null;
  }

  // Public getters
  String get title => _getTitle(newsItem);
  String? get image => _getImage(newsItem);
  String? get description => _getDescription(newsItem);
  String? get link => _getLink(newsItem);
}
