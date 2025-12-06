import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_depi_final_project/core/routes/app_pages.dart';
import '../controllers/favorites_controller.dart';

class FavoritesScreen extends GetView<FavoritesController> {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),

      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
        elevation: 0,

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: Colors.blueAccent,
          ),
        ),
      ),

      body: Obx(() {
        if (controller.favoriteItems.isEmpty) {
          return _buildEmptyState();
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.favoriteItems.length,
          itemBuilder: (context, index) {
            final category = controller.favoriteItems[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
                border: Border.all(
                  color: Colors.blueAccent.withOpacity(0.5),
                  width: 1.2,
                ),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),

                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.07),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blueAccent),
                  ),
                  child: Center(
                    child: category.imageUrl != null &&
                        category.imageUrl!.isNotEmpty
                        ? Image.asset(
                      category.imageUrl!,
                      width: 32,
                      height: 32,
                    )
                        : Text(
                      category.icon ?? "📰",
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                ),

                title: Text(
                  category.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                trailing: GestureDetector(
                  onTap: () =>
                      controller.removeFromFavorites(category, category.name),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.blueAccent,
                    size: 28,
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 90,
            color: Colors.blueAccent.withOpacity(0.4),
          ),
          const SizedBox(height: 20),

          const Text(
            'No favorites yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            'Add categories to see them here',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
