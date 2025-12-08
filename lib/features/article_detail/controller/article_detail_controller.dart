import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:news_depi_final_project/core/contoller/LanguageController.dart';
import 'package:news_depi_final_project/features/news/data/model/article.dart';

enum TtsState { playing, stopped, paused, continued }

class ArticleDetailController extends GetxController {
  Article? article;

  var isLiked = false.obs;
  var ttsState = TtsState.stopped.obs;

  var vibrantColor = Rx<Color>(Colors.blueAccent);
  var vibrantTextColor = Rx<Color>(Colors.white);

  final FlutterTts _flutterTts = FlutterTts();

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Article) {
      article = args;
    }
    _initTts();
  }

  String get displayContent {
    if (article == null) return "";

    // Check Language
    final isArabic = Get.find<LanguageController>().isArabic;

    if (isArabic &&
        article!.contentAr != null &&
        article!.contentAr!.isNotEmpty) {
      return article!.contentAr!;
    } else if (!isArabic &&
        article!.contentEn != null &&
        article!.contentEn!.isNotEmpty) {
      return article!.contentEn!;
    }

    // Fallback
    return article!.description ?? article!.content ?? "";
  }

  void toggleLike() {
    isLiked.value = !isLiked.value;
  }

  // ================= Text-to-Speech (TTS) =================
  void _initTts() {
    _flutterTts.setSpeechRate(0.5);

    _flutterTts.setStartHandler(() {
      ttsState.value = TtsState.playing;
    });

    _flutterTts.setCompletionHandler(() {
      ttsState.value = TtsState.stopped;
    });

    _flutterTts.setCancelHandler(() {
      ttsState.value = TtsState.stopped;
    });

    _flutterTts.setPauseHandler(() {
      ttsState.value = TtsState.paused;
    });

    _flutterTts.setContinueHandler(() {
      ttsState.value = TtsState.continued;
    });

    _flutterTts.setErrorHandler((msg) {
      ttsState.value = TtsState.stopped;
    });
  }

  Future<void> speak() async {
    String textToSpeak = displayContent;
    if (textToSpeak.isEmpty) {
      textToSpeak = article?.title ?? "";
    }

    if (textToSpeak.isNotEmpty) {
      bool isArabic = RegExp("[\u0600-\u06FF]").hasMatch(textToSpeak);
      if (isArabic) {
        await _flutterTts.setLanguage("ar");
      } else {
        await _flutterTts.setLanguage("en-US");
      }

      ttsState.value = TtsState.playing;

      await _flutterTts.speak(textToSpeak);
    }
  }

  Future<void> pauseTts() async {
    ttsState.value = TtsState.paused;
    await _flutterTts.pause();
  }

  Future<void> stopTts() async {
    ttsState.value = TtsState.stopped;
    await _flutterTts.stop();
  }

  @override
  void onClose() {
    _flutterTts.stop();
    super.onClose();
  }
}
