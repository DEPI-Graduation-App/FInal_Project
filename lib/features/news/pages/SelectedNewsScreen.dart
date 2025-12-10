import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:news_depi_final_project/generated/l10n.dart';
import '../controller/SNSController.dart';
import 'NewsTab.dart';
import '../../briefing/controller/briefing_controller.dart';


class SelectedNewsScreen extends GetView<SelectedNewsController> {
  const SelectedNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.loadAllNews(controller.Name);

    final Color mainColor = const  Color(0xFFD62828);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,


        // ---------- AppBar ----------
        appBar: AppBar(
          backgroundColor: Color(0xFF0A1A2F),

          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: mainColor),
            onPressed: () => Get.back(),
          ),
          actions: [
            IconButton(
              onPressed: () {
                controller.favController.toggleFavorite(controller.category, controller.Name);
              },
              icon: Obx(() {
                return Icon(
                  controller.favController.isFavorite(controller.category)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: controller.favController.isFavorite(controller.category)
                      ? mainColor
                      : mainColor.withOpacity(0.5),
                );
              }),
            ),
          ],
          title: Column(
            children: [
              Text(
                controller.Name,
                style: TextStyle(fontWeight: FontWeight.bold, color: mainColor),
              ),
              SizedBox(
                height: 36,
                child: TextField(
                  onSubmitted: (value) {
                    controller.searchNews(value);
                  },
                  decoration: InputDecoration(
                    hint: Text(
                      S.of(context).searchNewsHint,
                      style: TextStyle(color: mainColor, fontSize: 15),
                    ),
                    filled: true,
                   // fillColor: Colors.transparent, // شفافة
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(0xFFD62828), width: 1),
                    ),
                    suffixIcon: Icon(Icons.search, color: mainColor),
                  ),
                ),
              ),
            ],
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  S.of(context).source1,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: mainColor),
                ),
              ),
              Tab(
                child: Text(
                  S.of(context).source2,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: mainColor),
                ),
              ),
            ],
          ),
        ),

        // ---------- Body ----------
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return TabBarView(
            children: [
              NewsTab(apiKey: 'gnews', articles: controller.gnewsArticles),
              NewsTab(apiKey: 'newsApi', articles: controller.newsApiArticles),
            ],
          );
        }),

        // ---------- Floating Action Button ----------
        floatingActionButton: Obx(() {
          final hasArticles =
              controller.newsApiArticles.isNotEmpty || controller.gnewsArticles.isNotEmpty;

          if (controller.currentTopic.isEmpty || !hasArticles || controller.isLoading.value || !controller.isSearchMode.value) {
            return const SizedBox.shrink();
          }

          final briefingController = Get.find<AiBriefingController>();
          final topicName = controller.currentTopic.value;

          final matchingTopic = briefingController.staticTopics.firstWhere(
                (t) => t['value'] == topicName.toLowerCase() || t['label'] == topicName,
            orElse: () => {},
          );

          final topicId = matchingTopic.isNotEmpty ? matchingTopic['value']! : topicName;
          final isLoading = briefingController.loadingTopicIds.contains(topicId);
          final isCached = briefingController.cachedSummaries.containsKey(topicId);

          return GestureDetector(
            onTap: () {
              // اختياري: تنفيذ أي إجراء عند الضغط
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: mainColor), // إطار قرمزي
                gradient: LinearGradient(
                  colors: isLoading
                      ? [mainColor.withOpacity(0.8), mainColor.withOpacity(0.5)]
                      : (isCached
                      ? [mainColor.withOpacity(0.5), mainColor.withOpacity(0.8)]
                      : [mainColor.withOpacity(0.6), mainColor]),
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: mainColor.withOpacity(0.5),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isLoading)
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: mainColor,
                      ),
                    )
                  else
                    Icon(
                      isCached ? Icons.check_circle : Icons.auto_awesome,
                      color: mainColor,
                    ),
                  const SizedBox(width: 8),
                  Text(
                    isLoading
                        ? S.of(context).analyzing
                        : (isCached
                        ? S.of(context).briefingReadyShort
                        : S.of(context).generateSummary),
                    style: TextStyle(
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
