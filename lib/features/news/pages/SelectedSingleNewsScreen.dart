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
      backgroundColor: const Color(0xff0D0D0D),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blueAccent),
          onPressed: () => Get.back(),
        ),
        title: Text(
          controller.title,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ---------- IMAGE ----------
            if (controller.image != null && controller.image!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent.withOpacity(0.25),
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                        )
                      ],
                    ),
                    child: Image.network(
                      controller.image!,
                      height: 260,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Container(height: 260, color: Colors.grey[800]),
                    ),
                  ),
                ),
              ),

            // ---------- DESCRIPTION CARD ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xff151515),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  controller.description ??
                      S.of(context).noSummaryAvailable,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ---------- VIEW ARTICLE BUTTON ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade400,
                      Colors.blueAccent.shade700,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
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
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    S.of(context).viewArticle,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ---------- SIMILAR NEWS HEADER ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                S.of(context).similarNews,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ---------- HORIZONTAL SIMILAR NEWS ----------
            Obx(() {
              if (controller.similarArticles.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    S.of(context).noSimilarNewsFound,
                    style: const TextStyle(color: Colors.grey),
                  ),
                );
              }

              return SizedBox(
                height: 150,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: controller.similarArticles.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 14),
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
                            backgroundColor: Colors.redAccent,
                            colorText: Colors.white,
                          );
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          width: 140,
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              )
                            ],
                          ),
                          child: Image.network(
                            sim is Article
                                ? (sim.urlToImage ?? '')
                                : (sim as GnewsArticle).image ?? '',
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
