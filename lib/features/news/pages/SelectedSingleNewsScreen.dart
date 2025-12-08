import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_depi_final_project/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/SelectedSingleNewsController.dart';
import '../data/model/GnewsModel.dart';
import '../data/model/NewsApiModel.dart';

class SelectedSingleNewsScreen extends GetView<SelectedSingleNewsController> {
  const SelectedSingleNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.title, overflow: TextOverflow.ellipsis),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            if (controller.image != null && controller.image!.isNotEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(12),
                ),
                child: Image.network(
                  controller.image!,
                  width: double.infinity,
                  height: 260,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(height: 260, color: Colors.grey[300]),
                ),
              )
            else
              Container(
                height: 260,
                width: double.infinity,
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.image_not_supported, size: 40),
                ),
              ),

            // Description
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                controller.description ?? S.of(context).noSummaryAvailable,
                style: const TextStyle(fontSize: 14, height: 1.4),
              ),
            ),

            // View Article Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () async {
                  if (controller.link != null &&
                      Uri.tryParse(controller.link!) != null) {
                    await launchUrl(
                      Uri.parse(controller.link!),
                      mode: LaunchMode.externalApplication,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(
                  S.of(context).viewArticle,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Similar News Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                S.of(context).similarNews,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Similar News List
            Obx(() {
              if (controller.similarArticles.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(S.of(context).noSimilarNewsFound),
                );
              }

              return SizedBox(
                height: 110,
                child: Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: controller.similarArticles.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final sim = controller.similarArticles[index];

                      return GestureDetector(
                        onTap: () async {
                          final url = sim is Article
                              ? sim.url
                              : (sim as GnewsArticle).url;
                          if (url != null && Uri.tryParse(url) != null) {
                            await launchUrl(
                              Uri.parse(url),
                              mode: LaunchMode.externalApplication,
                            );
                          } else {
                            Get.snackbar(
                              "Error",
                              S.of(context).cannotOpenArticle,
                            );
                          }
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: sim is Article || sim is GnewsArticle
                              ? Image.network(
                                  sim is Article
                                      ? sim.urlToImage ?? ''
                                      : sim.image ?? '',
                                  width: 120,
                                  height: 110,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    width: 120,
                                    height: 110,
                                    color: Colors.grey[300],
                                  ),
                                )
                              : Container(
                                  width: 120,
                                  height: 110,
                                  color: Colors.grey[300],
                                ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
