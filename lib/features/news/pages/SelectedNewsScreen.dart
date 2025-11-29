import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/SNSController.dart';
import '../data/model/NewsApiModel.dart';
import '../data/model/GnewsModel.dart';
import '../data/model/CurrentsNewsModel.dart';
import 'GNewsTab.dart';

class SelectedNewsScreen extends StatelessWidget {
  const SelectedNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SelectedNewsController());
    final category = Get.arguments as String;

    controller.loadAllNews(category);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(category, style: const TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          bottom: const TabBar(
            tabs: [
              Tab(text: "GNews"),
              Tab(text: "NewsAPI"),
              Tab(text: "Currents"),
            ],
          ),
        ),
        backgroundColor: const Color(0xffF7F8FA),
        body: TabBarView(
          children: [
            NewsTab(apiKey: 'gnews', articles: controller.gnewsArticles),
            NewsTab(apiKey: 'newsApi', articles: controller.newsApiArticles),
            NewsTab(apiKey: 'currents', articles: controller.currentsArticles),
          ],
        ),
      ),
    );
  }
}
