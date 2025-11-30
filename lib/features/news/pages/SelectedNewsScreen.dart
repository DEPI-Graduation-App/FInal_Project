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
    //final favController = Get.put(FavoritesController);
    final category = Get.arguments as String;
    controller.loadAllNews(category);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                /// Toggle favorite status & add or remove from favorites & save to storage
                //favController.toggleFavoriteIcon(title);
              },
              icon: const Icon(Icons.favorite_border),
              // icon: Obx(() {
              //   return Icon(
              //       //favController.isFavorite() ?
              //       //Icons.favorite :
              //       Icons.favorite_border
              //   );
              // }),
              //color: controller.isFavorite.value ? Colors.red : Colors.black,
            ),
          ],
          title: Text(
              category, style: const TextStyle(fontWeight: FontWeight.bold)),
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
