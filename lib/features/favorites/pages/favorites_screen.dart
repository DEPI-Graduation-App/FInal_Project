import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_depi_final_project/core/routes/app_pages.dart';
import 'package:news_depi_final_project/generated/l10n.dart';
import '../controllers/favorites_controller.dart';

class FavoritesScreen extends GetView<FavoritesController> {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,

        title: Text(
          S.of(context).favoritesTitle,
          style: const TextStyle(
            color: Color(0xFFD62828),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: Colors.blueAccent.withOpacity(0.5),
          ),
        ),
      ),

      body: Obx(() {
        if (controller.favoriteItems.isEmpty) {
          return _buildEmptyState(context);
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.favoriteItems.length,
          itemBuilder: (context, index) {
            final category = controller.favoriteItems[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Color(0xFFD62828),                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.blueAccent.withOpacity(0.5),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),

                leading: Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Color(0xFFD62828).withOpacity(0.07),
                    borderRadius: BorderRadius.circular(12),
                   border: Border.all(     color: Color(0xFFD62828), width: 1.1),
                  ),
                  child: Center(
                    child: category.imageUrl != null &&
                        category.imageUrl!.isNotEmpty
                        ? Image.asset(category.imageUrl!, width: 34, height: 34)
                        : Text(
                      category.icon ?? "📰",
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                ),

                title: Text(
                  _getLocalizedCategoryName(context, category.name),
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFD62828),
                  ),
                ),

                trailing: GestureDetector(
                  onTap: () => controller.removeFromFavorites(
                    category,
                    category.name,
                  ),
                  child: Icon(
                    Icons.favorite,
                    color: Color(0xFFD62828),
                    size: 30,
                  ),
                ),

                onTap: () {
                  Get.toNamed(
                    AppPages.SelectedNews,
                    arguments: [category.name, category],
                  );
                },
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 100,
            color: Colors.red.withOpacity(0.4),
          ),
          const SizedBox(height: 20),

          Text(
            S.of(context).noFavoritesYet,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFFD62828),            ),
          ),

          const SizedBox(height: 10),

          Text(
            S.of(context).addCategoriesToSeeThem,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        ],
      ),
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
