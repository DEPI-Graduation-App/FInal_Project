import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_depi_final_project/generated/l10n.dart';
import '../controller/SNSController.dart';
import 'NewsTab.dart';
import '../../home/data/model/category_model.dart';

class SelectedNewsScreen extends GetView<SelectedNewsController> {
  const SelectedNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final name = Get.arguments[0];
    final Category category = Get.arguments[1];
    controller.loadAllNews(category.id);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                //controller.favController.toggleFavoriteIcon(Name);
                controller.favController.toggleFavorite(category, name);
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
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
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
      ),
    );
  }
}
