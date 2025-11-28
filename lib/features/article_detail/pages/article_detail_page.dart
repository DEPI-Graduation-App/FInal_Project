import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_depi_final_project/features/article_detail/controller/article_detail_controller.dart';
import 'package:share_plus/share_plus.dart';

class ArticleDetailsPage extends StatelessWidget {
  const ArticleDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ArticleDetailController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        final dynamicColor = controller.vibrantColor.value;
        return _buildContent(context, dynamicColor, controller);
      }),
    );
  }

  Widget _buildContent(
    BuildContext context,
    Color dynamicColor,
    ArticleDetailController controller,
  ) {
    final article = controller.article;

    if (article == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // ================= App Bar & Image =================
        SliverAppBar(
          expandedHeight: 320,
          pinned: true,
          stretch: true,
          backgroundColor: Colors.white,

          leading: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: Colors.white,
              ),
              onPressed: () => Get.back(),
            ),
          ),

          actions: [
            _buildGlassActionButton(
              icon: Icons.share,
              onTap: () {
                Share.share("${article.title}\n${article.articleUrl}");
                Get.snackbar("Share", "Sharing feature coming soon!");
              },
            ),
            const SizedBox(width: 8),

            Obx(
              () => _buildGlassActionButton(
                icon: controller.isLiked.value
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: controller.isLiked.value
                    ? Colors.redAccent
                    : Colors.white,
                onTap: () => controller.toggleLike(),
              ),
            ),
            const SizedBox(width: 16),
          ],

          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [StretchMode.zoomBackground],
            background: Stack(
              fit: StackFit.expand,
              children: [
                _buildSmartImage(article.imageUrl),

                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black26,
                        Colors.transparent,
                        Colors.black87,
                      ],
                      stops: [0.0, 0.5, 1.0],
                    ),
                  ),
                ),

                Positioned(
                  bottom: 16,
                  left: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: dynamicColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      article.sourceName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    height: 1.3,
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 5),
                    Text(
                      article.publishedAt.toString().split(' ')[0],
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),

                    IconButton(
                      onPressed: () {
                        if (controller.ttsState.value == TtsState.playing) {
                          controller.stopTts();
                        } else {
                          controller.speak();
                        }
                      },
                      icon: Obx(
                        () => Icon(
                          controller.ttsState.value == TtsState.playing
                              ? Icons.stop_circle
                              : Icons.play_circle_fill,
                          size: 40,
                          color: dynamicColor,
                        ),
                      ),
                    ),
                  ],
                ),

                const Divider(height: 40),

                // الوصف / الملخص
                Text(
                  article.description ?? "No description available.",
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.6,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGlassActionButton({
    required IconData icon,
    required VoidCallback onTap,
    Color color = Colors.white,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: IconButton(
            icon: Icon(icon, color: color, size: 20),
            onPressed: onTap,
          ),
        ),
      ),
    );
  }

  Widget _buildSmartImage(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return Container(
        color: Colors.grey[300],
        child: const Icon(Icons.image, size: 50, color: Colors.grey),
      );
    }
    if (imageUrl.startsWith('http')) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(color: Colors.grey),
      );
    }
    return Image.asset(
      imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(color: Colors.grey),
    );
  }
}
