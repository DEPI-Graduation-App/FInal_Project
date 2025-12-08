import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_depi_final_project/generated/l10n.dart';
import '../controller/SNSController.dart';
import 'NewsTab.dart';
import '../../home/data/model/category_model.dart';
import '../../briefing/controller/briefing_controller.dart';

class SelectedNewsScreen extends GetView<SelectedNewsController> {
  const SelectedNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Name = Get.arguments[0];
    final category = Get.arguments[1];
    controller.loadAllNews(Name);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                //controller.favController.toggleFavoriteIcon(Name);
                controller.favController.toggleFavorite(category, Name);
              },
              icon: Obx(() {
                return Icon(
                  controller.favController.isFavorite(category)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: controller.favController.isFavorite(category)
                      ? Colors.blueAccent
                      : Colors.black,
                );
              }),
            ),
          ],
          title: Column(
            children: [
              Text(Name, style: const TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(
                height: 36,
                child: TextField(
                  onSubmitted: (value) {
                    controller.searchNews(value);
                  },
                  decoration: InputDecoration(
                    hintText: S.of(context).searchNewsHint,
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: S.of(context).source1),
              Tab(text: S.of(context).source2),
            ],
          ),
        ),

        backgroundColor: const Color(0xffF7F8FA),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return TabBarView(
            children: [
              NewsTab(apiKey: 'gnews', articles: controller.gnewsArticles),
              NewsTab(apiKey: 'newsApi', articles: controller.newsApiArticles),
            ],
          );
        }),
        floatingActionButton: Obx(() {
          final hasArticles =
              controller.newsApiArticles.isNotEmpty ||
              controller.gnewsArticles.isNotEmpty;
          if (controller.currentTopic.isEmpty ||
              !hasArticles ||
              controller.isLoading.value ||
              !controller.isSearchMode.value) {
            return const SizedBox.shrink();
          }

          final briefingController = Get.find<AiBriefingController>();
          final topicName = controller.currentTopic.value;

          // Determine topic ID (value)
          final matchingTopic = briefingController.staticTopics.firstWhere(
            (t) =>
                t['value'] == topicName.toLowerCase() ||
                t['label'] == topicName,
            orElse: () => {},
          );
          final topicId = matchingTopic.isNotEmpty
              ? matchingTopic['value']!
              : topicName;

          final isLoading = briefingController.loadingTopicIds.contains(
            topicId,
          );
          final isCached = briefingController.cachedSummaries.containsKey(
            topicId,
          );

          return GestureDetector(
            onTap: () {
              String image = 'assets/images/general.png';
              if (matchingTopic.isNotEmpty) {
                image = matchingTopic['image']!;
              } else {
                if (controller.newsApiArticles.isNotEmpty) {
                  final article = controller.newsApiArticles.firstWhere(
                    (a) => a.urlToImage != null && a.urlToImage!.isNotEmpty,
                    orElse: () => controller.newsApiArticles.first,
                  );
                  if (article.urlToImage != null &&
                      article.urlToImage!.isNotEmpty) {
                    image = article.urlToImage!;
                  }
                } else if (controller.gnewsArticles.isNotEmpty) {
                  final article = controller.gnewsArticles.firstWhere(
                    (a) => a.image.isNotEmpty,
                    orElse: () => controller.gnewsArticles.first,
                  );
                  if (article.image.isNotEmpty) {
                    image = article.image;
                  }
                }
              }

              final label = matchingTopic.isNotEmpty
                  ? matchingTopic['label']!
                  : topicName;

              briefingController.selectAndSummarizeTopic({
                'label': label,
                'value': topicName,
                'image': image,
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isLoading
                      ? [Colors.grey.shade400, Colors.grey.shade600]
                      : (isCached
                            ? [Colors.green.shade400, Colors.green.shade700]
                            : [
                                Colors.blue.shade400,
                                Colors.blueAccent.shade700,
                              ]),
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color:
                        (isLoading
                                ? Colors.grey
                                : (isCached ? Colors.green : Colors.blueAccent))
                            .withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isLoading)
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  else
                    Icon(
                      isCached ? Icons.check_circle : Icons.auto_awesome,
                      color: Colors.white,
                    ),
                  const SizedBox(width: 8),
                  Text(
                    isLoading
                        ? S.of(context).analyzing
                        : (isCached
                              ? S.of(context).briefingReadyShort
                              : S.of(context).generateSummary),
                    style: const TextStyle(
                      color: Colors.white,
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
