import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:news_depi_final_project/features/news/data/model/article.dart';

enum TtsState { playing, stopped, paused, continued }

class ArticleDetailController extends GetxController {
  Article? article;

  var isLiked = false.obs;

  var ttsState = TtsState.stopped.obs;

  var vibrantColor = Rx<Color>(Colors.blueAccent);
  var vibrantTextColor = Rx<Color>(Colors.white);

  final FlutterTts _flutterTts = FlutterTts();

  // ================= init =================
  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;

    if (args is Article) {
      article = args;

      Future.delayed(const Duration(milliseconds: 50), () {
        // _generatePalette();
      });
    }

    _initTts();
  }

  // ================= Actions =================

  void toggleLike() {
    isLiked.value = !isLiked.value;
  }

  // ================= Text-to-Speech (TTS) =================
  void _initTts() {
    _flutterTts.setSpeechRate(0.5);
    _flutterTts.setStartHandler(() => ttsState.value = TtsState.playing);
    _flutterTts.setCompletionHandler(() => ttsState.value = TtsState.stopped);
    _flutterTts.setCancelHandler(() => ttsState.value = TtsState.stopped);
    _flutterTts.setPauseHandler(() => ttsState.value = TtsState.paused);
    _flutterTts.setContinueHandler(() => ttsState.value = TtsState.continued);
    _flutterTts.setErrorHandler((msg) => ttsState.value = TtsState.stopped);
  }

  Future<void> speak() async {
    String textToSpeak = article?.description ?? article?.title ?? "";

    if (textToSpeak.isNotEmpty) {
      bool isArabic = RegExp("[\u0600-\u06FF]").hasMatch(textToSpeak);

      if (isArabic) {
        await _flutterTts.setLanguage("ar");
      } else {
        await _flutterTts.setLanguage("en-US");
      }
      await _flutterTts.speak(textToSpeak);
    }
  }

  Future<void> pauseTts() async => await _flutterTts.pause();
  Future<void> stopTts() async => await _flutterTts.stop();

  // ================= dynamic colors =================
  // Future<void> _generatePalette() async {
  //   if (article?.imageUrl == null) return;

  //   try {
  //     final String imagePath = article!.imageUrl!;
  //     Uint8List imageBytes;

  //     if (imagePath.startsWith('http')) {
  //       final networkImage = await NetworkAssetBundle(
  //         Uri.parse(imagePath),
  //       ).load(imagePath);
  //       imageBytes = networkImage.buffer.asUint8List();
  //     } else {
  //       final byteData = await rootBundle.load(imagePath);
  //       imageBytes = byteData.buffer.asUint8List();
  //     }

  //     final color = await compute(_extractDominantColor, imageBytes);
  //     vibrantColor.value = color;

  //     vibrantTextColor.value = color.computeLuminance() > 0.5
  //         ? Colors.black
  //         : Colors.white;
  //   } catch (e) {
  //     debugPrint("Color gen error: $e");
  //   }
  // }

  // static Color _extractDominantColor(Uint8List bytes) {
  //   final img.Image? decoded = img.decodeImage(bytes);
  //   if (decoded == null) return Colors.blueAccent;
  //   return Color.fromRGBO(
  //     decoded.getPixel(0, 0).r.toInt(),
  //     decoded.getPixel(0, 0).g.toInt(),
  //     decoded.getPixel(0, 0).b.toInt(),
  //     1,
  //   );
  // }
}
