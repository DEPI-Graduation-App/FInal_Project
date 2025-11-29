import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_depi_final_project/features/article_detail/widgets/build_tts_controls.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:news_depi_final_project/features/article_detail/controller/article_detail_controller.dart';

class ArticleDetailsPage extends GetView<ArticleDetailController> {
  const ArticleDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
        // ================= Sliver App Bar (Image & Nav) =================
        SliverAppBar(
          expandedHeight: 320,
          pinned: true,
          stretch: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,

          // --- Leading Back Button (Frosted Glass) ---
          leading: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 18,
                    color: Colors.white,
                  ),
                  onPressed: () => Get.back(),
                ),
              ),
            ),
          ),

          // --- Action Buttons (Share & Like) ---
          actions: [
            _buildGlassActionButton(
              icon: Icons.share_rounded,
              onTap: () =>
                  Share.share("${article.title}\n${article.description}"),
            ),
            const SizedBox(width: 8), // AppGaps.h8

            Obx(() {
              final isFav = controller.isLiked.value;

              return _buildGlassActionButton(
                icon: isFav
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: isFav ? Colors.redAccent : Colors.white,
                onTap: () {
                  controller.toggleLike();
                },
              );
            }),
            const SizedBox(width: 16), // AppGaps.h16
          ],

          // --- Background Image & Gradient ---
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.zoomBackground,
              StretchMode.blurBackground,
            ],
            background: Stack(
              fit: StackFit.expand,
              children: [
                // 1. The Main Image
                Hero(
                  tag: article.imageUrl ?? article.title,
                  child: _buildSmartImage(context, article.imageUrl),
                ),

                // 2. Gradient Overlay
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

                // 3. Source Badge
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
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.newspaper_rounded,
                          color: Colors.white,
                          size: 14,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          article.sourceName,
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // ================= Article Content Body =================
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- 1. Title ---
                Text(
                  article.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    height: 1.3,
                  ),
                ),

                const SizedBox(height: 16),

                // --- 2. Metadata Row (Time & TTS) ---
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 16,
                      color: Theme.of(
                        context,
                      ).textTheme.bodySmall?.color?.withOpacity(0.6),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      timeago.format(article.publishedAt),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(
                          context,
                        ).textTheme.bodySmall?.color?.withOpacity(0.6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),

                    // ====> TTS Widget Here <====
                    buildTtsControls(context, dynamicColor, controller),
                  ],
                ),

                const SizedBox(height: 24),
                Divider(
                  color: Theme.of(context).dividerColor.withOpacity(0.1),
                  thickness: 1,
                ),
                const SizedBox(height: 24),

                // --- 3. Description Text ---
                Text(
                  article.description ?? "No description available.",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 17,
                    height: 1.7,
                    color: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.color?.withOpacity(0.85),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ================= Helpers =================
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
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(icon, color: color, size: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSmartImage(BuildContext context, String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return Container(
        color: Theme.of(context).colorScheme.surface,
        child: Icon(
          Icons.broken_image_rounded,
          size: 50,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
        ),
      );
    }

    if (imageUrl.startsWith('http') || imageUrl.startsWith('https')) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        memCacheWidth: 800,
        placeholder: (context, url) => Container(
          color: Theme.of(context).colorScheme.surface.withOpacity(0.15),
          child: const Center(
            child: CircularProgressIndicator(strokeWidth: 1.5),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          color: Theme.of(context).colorScheme.surface,
          child: Icon(
            Icons.broken_image_rounded,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
            size: 40,
          ),
        ),
      );
    }

    return Image.asset(
      imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Theme.of(context).colorScheme.surface,
          child: Icon(
            Icons.broken_image_rounded,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
            size: 40,
          ),
        );
      },
    );
  }
}
