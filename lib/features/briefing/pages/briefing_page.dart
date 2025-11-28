import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:news_depi_final_project/features/briefing/controller/briefing_controller.dart';
import 'package:news_depi_final_project/features/briefing/widgets/build_smart_topic_card.dart';
import 'package:news_depi_final_project/features/news/data/model/article.dart'; // تأكد من المسار

class AiBriefingPage extends GetView<AiBriefingController> {
  const AiBriefingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final topics = controller.staticTopics;
    final todayDate = DateFormat('EEEE, d MMMM').format(DateTime.now());

    const Color primaryColor = Colors.blueAccent;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: 150,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: const Text(
                "AI News Briefing",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20, top: 50),
                child: Text(
                  todayDate,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            ),
          ),

          // List using Smart Cards
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final topicMap = topics[index];

                final displayArticle = Article(
                  id: topicMap['value']!,
                  title: topicMap['label']!,
                  imageUrl: topicMap['image'],
                  description: '',
                  sourceName: '',
                  publishedAt: DateTime.now(),
                  articleUrl: '',
                  author: '',
                );

                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: buildSmartTopicCard(
                    context,
                    displayArticle,
                    topicMap,
                    controller,
                    primaryColor,
                  ),
                );
              }, childCount: topics.length),
            ),
          ),
        ],
      ),
    );
  }
}
