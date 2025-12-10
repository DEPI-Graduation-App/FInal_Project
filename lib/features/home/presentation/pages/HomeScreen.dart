import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_depi_final_project/generated/l10n.dart';
import '../controller/HomeController.dart';
import '../../../../core/constants/assets_manager.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          S.of(context).homeTitle,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,

      ),


      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.blueAccent),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            children: [
              Column(
                children: [
                  Image.asset(AssetsManager.logo, width: 140, height: 140),
                ],
              ),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(color: Colors.grey.shade300, thickness: 1),
              ),

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    S.of(context).newsCategories,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 4),
                itemCount: controller.categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: .92,
                ),
                itemBuilder: (context, index) {
                  final category = controller.categories[index];

                  return GestureDetector(
                    onTap: () => controller.onCategoryTap(category, index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.blueAccent,
                          width: 1.4,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          category.imageUrl != null &&
                                  category.imageUrl!.isNotEmpty
                              ? Image.asset(
                                  category.imageUrl!,
                                  width: 46,
                                  height: 46,
                                )
                              : Text(
                                  category.icon ?? "📰",
                                  style: const TextStyle(fontSize: 32,color: Colors.white),
                                ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              _getLocalizedCategoryName(context, category.name),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }

  String _getLocalizedCategoryName(BuildContext context, String categoryName) {
    final s = S.of(context);
    switch (categoryName.toLowerCase()) {
      case 'business':
        return s.business;
      case 'entertainment':
        return s.entertainment;
      case 'general':
        return s.general;
      case 'health':
        return s.health;
      case 'science':
        return s.science;
      case 'sports':
        return s.sports;
      case 'technology':
        return s.technology;
      default:
        return categoryName;
    }
  }
}
