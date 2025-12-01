import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../favorites/controllers/favorites_controller.dart';
import '../controller/SNSController.dart';
import 'NewsTab.dart';

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
                    hintText: "Search news...",
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: "Source1"),
              Tab(text: "Source2"),
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
