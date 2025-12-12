import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_depi_final_project/features/article_detail/widgets/build_tts_controls.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:news_depi_final_project/features/article_detail/controller/article_detail_controller.dart';
import 'package:news_depi_final_project/generated/l10n.dart';

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
                    color: Color(0xFFD62828),
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
              color: Color(0xFFD62828),
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
                color: isFav ? Colors.redAccent : Colors.red,
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
                         Color(0xFFD62828),                      ],
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
                      color: Color(0xFFD62828),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFD62828).withOpacity(0.2),
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
                          article.isAiGenerated
                              ? S.of(context).aiBriefingSource
                              : article.sourceName,
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
                  article.isAiGenerated
                      ? S
                            .of(context)
                            .briefingTitle(
                              _getLocalizedTopicLabel(context, article.id),
                            )
                      : article.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    height: 1.3,
                    color: Color(0xFFD62828),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Text(
                    controller.displayContent.isNotEmpty
                        ? controller.displayContent
                        : S.of(context).noDescriptionAvailable,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 17,
                      height: 1.7,
                      color: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.color?.withOpacity(0.85),
                    ),
                  ),
                ),

                SizedBox(height: 24),
                // --- 4. Sources Section ---
                if (article.sources != null && article.sources!.isNotEmpty) ...[
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.source_rounded,
                          color: Color(0xFFD62828),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        S.of(context).aiBriefingSource,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: article.sources!.map((source) {
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            final uri = Uri.parse(source.url);
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(
                                uri,
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Theme.of(
                                  context,
                                ).dividerColor.withOpacity(0.1),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://www.google.com/s2/favicons?sz=64&domain_url=${source.url}",
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Icon(
                                      Icons.public,
                                      size: 16,
                                      color: Color(0xFFD62828),                                    ),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.public,
                                      size: 16,
                                      color: Color(0xFFD62828),                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  source.name,
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium?.color,
                                      ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.arrow_outward_rounded,
                                  size: 14,
                                  color: Theme.of(context).disabledColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 40),
                ],
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
    Color color = Colors.red,
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
          color: Color(0xFFD62828),        ),
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
            color: Color(0xFFD62828),            size: 40,
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
            color: Color(0xFFD62828),            size: 40,
          ),
        );
      },
    );
  }

  String _getLocalizedTopicLabel(BuildContext context, String topicId) {
    switch (topicId) {
      case 'general':
        return S.of(context).general;
      case 'sports':
        return S.of(context).sports;
      case 'technology':
        return S.of(context).technology;
      case 'business':
        return S.of(context).business;
      case 'science':
        return S.of(context).science;
      case 'health':
        return S.of(context).health;
      case 'entertainment':
        return S.of(context).entertainment;
      default:
        return topicId;
    }
  }
}
