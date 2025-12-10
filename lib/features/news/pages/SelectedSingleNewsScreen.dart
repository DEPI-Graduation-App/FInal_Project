import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_depi_final_project/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/SelectedSingleNewsController.dart';
import '../data/model/GnewsModel.dart';
import '../data/model/NewsApiModel.dart';

class SelectedSingleNewsScreen extends GetView<SelectedSingleNewsController> {
  const SelectedSingleNewsScreen({super.key});

  final Color mainColor = const Color(0xFFD62828); // اللون الأساسي القرمزي

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.white, // خلفية خفيفة

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: mainColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          controller.title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color:  Color(0xFFD62828) ,
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
                          color: mainColor,
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                        ),
                      ],
                      border: Border.all(color: mainColor, width: 2), // أي بوردر
                    ),
                    child: Image.network(
                      controller.image!,
                      height: 260,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Container(height: 260, color: mainColor.withOpacity(0.3)),
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
                  color: mainColor,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: mainColor.withOpacity(0.6),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: mainColor, width: 2),
                ),
                child: Text(
                  controller.description ?? S.of(context).noSummaryAvailable,
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
                    colors: [mainColor.withOpacity(0.8), mainColor],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: mainColor.withOpacity(0.5),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: mainColor, width: 2),
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
                    style: TextStyle(color: mainColor.withOpacity(0.8)),
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
                            backgroundColor: mainColor,
                            colorText: Colors.white,
                          );
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          width: 140,
                          decoration: BoxDecoration(
                            color: mainColor.withOpacity(0.1),
                            boxShadow: [
                              BoxShadow(
                                color: mainColor.withOpacity(0.5),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            border: Border.all(color: mainColor, width: 2),
                          ),
                          child: Image.network(
                            sim is Article
                                ? (sim.urlToImage ?? '')
                                : (sim as GnewsArticle).image ?? '',
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                Container(color: mainColor.withOpacity(0.2)),
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
