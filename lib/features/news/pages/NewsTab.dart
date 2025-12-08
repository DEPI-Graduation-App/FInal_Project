import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_depi_final_project/core/routes/app_pages.dart';
import 'package:news_depi_final_project/generated/l10n.dart';
import '../data/model/NewsApiModel.dart';
import '../data/model/GnewsModel.dart';

class NewsTab extends StatelessWidget {
  final String apiKey;
  final RxList<dynamic> articles;

  const NewsTab({required this.apiKey, required this.articles, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (articles.isEmpty) {
        return Center(child: Text(S.of(context).noNewsFound));
      }

      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: articles.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final item = articles[index];

          String title = '';
          String? image;
          String? desc;

          // newsApi Article
          if (item is Article) {
            title = item.title ?? '';
            image = item.urlToImage;
            desc = item.description;
          } else if (item is GnewsArticle) {
            title = item.title;
            image = item.image;
            desc = item.content;
          }

          return GestureDetector(
            onTap: () {
              Get.toNamed(AppPages.SelectedSingleNews, arguments: item);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (image != null && image.isNotEmpty)
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: Image.network(
                        image,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Container(height: 180, color: Colors.grey[300]),
                      ),
                    )
                  else
                    Container(height: 180, color: Colors.grey[300]),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  if (desc != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Text(
                        desc,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
