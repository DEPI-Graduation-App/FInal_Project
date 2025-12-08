import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_depi_final_project/features/briefing/controller/briefing_controller.dart';
import 'package:news_depi_final_project/generated/l10n.dart';

import '../../news/data/model/article.dart' show Article;

Widget buildSmartTopicCard(
  BuildContext context,
  Article displayArticle,
  Map<String, String> topicMap,
  AiBriefingController controller,
  Color primaryColor,
) {
  final topicId = topicMap['value']!;

  return TweenAnimationBuilder<double>(
    duration: const Duration(milliseconds: 600),
    curve: Curves.easeOutQuart,
    tween: Tween(begin: 0.0, end: 1.0),
    builder: (context, value, child) {
      return Transform.translate(
        offset: Offset(0, 30 * (1 - value)),
        child: Opacity(opacity: value, child: child),
      );
    },
    child: GestureDetector(
      onTap: () => controller.selectAndSummarizeTopic(topicMap),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 10),
              spreadRadius: -2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // 1. Image Background
              Image.asset(
                displayArticle.imageUrl ?? "assets/images/Sports.png",
                fit: BoxFit.cover,
              ),

              // 2. Gradient Overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.6),
                      Colors.black.withOpacity(0.9),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),

              // 3. Smart Content
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Obx(() {
                  final isLoading = controller.loadingTopicIds.contains(
                    topicId,
                  );
                  final isCached = controller.cachedSummaries.containsKey(
                    topicId,
                  );

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Top Row: Status Badge & Refresh
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isLoading
                                  ? primaryColor.withOpacity(0.9)
                                  : (isCached
                                        ? Colors.green.withOpacity(0.9)
                                        : Colors.white.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: isLoading || isCached
                                    ? Colors.transparent
                                    : Colors.white.withOpacity(0.3),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (isLoading)
                                  const SizedBox(
                                    width: 12,
                                    height: 12,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                else
                                  Icon(
                                    isCached
                                        ? Icons.check_circle
                                        : Icons.auto_awesome,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                const SizedBox(width: 8),
                                Text(
                                  isLoading
                                      ? S.of(context).analyzing
                                      : (isCached
                                            ? S.of(context).briefingReadyShort
                                            : S.of(context).generateSummary),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          if (isCached && !isLoading)
                            GestureDetector(
                              onTap: () => controller.selectAndSummarizeTopic(
                                topicMap,
                                forceRefresh: true,
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                        ],
                      ),

                      // Bottom Row: Title & Action
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              displayArticle.title.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 24,
                                letterSpacing: 1.0,
                                height: 1.0,
                              ),
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isLoading
                                  ? Colors.white
                                  : (isCached ? Colors.green : primaryColor),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      (isCached ? Colors.green : primaryColor)
                                          .withOpacity(0.4),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: isLoading
                                ? SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: primaryColor,
                                    ),
                                  )
                                : Icon(
                                    isCached
                                        ? Icons.print
                                        : Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
