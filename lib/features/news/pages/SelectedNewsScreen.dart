import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../favorites/controllers/favorites_controller.dart';
import '../controller/SNSController.dart';
import 'GNewsTab.dart';

class SelectedNewsScreen extends StatelessWidget {
  const SelectedNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SelectedNewsController());
    final favController = Get.put(FavoritesController());
    final Name=Get.arguments[0];
    final category=Get.arguments[1];
    controller.loadAllNews(Name);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                favController.toggleFavoriteIcon(Name);
                favController.toggleFavorite(category);
              },
              icon: Obx(() {
                return Icon(
                  favController.isFavorite(category)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: favController.isFavorite(category)
                      ? Colors.red
                      : Colors.black,
                );
              }),
            ),
          ],
          title: Text(
              Name  , style: const TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          bottom: const TabBar(
            tabs: [
              Tab(text: "GNews"),
              Tab(text: "NewsAPI"),
            ],
          ),
        ),
        backgroundColor: const Color(0xffF7F8FA),
        body: TabBarView(
          children: [
            NewsTab(apiKey: 'gnews', articles: controller.gnewsArticles),
            NewsTab(apiKey: 'newsApi', articles: controller.newsApiArticles),
          ],
        ),
      ),
    );
  }
}
