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
    final Color mainColor = const Color(0xFFD62828FF);

    // تحديد لون الخلفية حسب الثيم
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color backgroundColor = isDark ? Color(0xFF0A1A2F) : Colors.white;
    final Color textColor = isDark ? Colors.white : Colors.black;
    final Color subtitleColor = isDark ? Colors.grey[400]! : Colors.grey[700]!;

    return Container(
      color: backgroundColor, // يعتمد على المود
      child: Obx(() {
        if (articles.isEmpty) {
          return Center(
            child: Text(
              S.of(context).noNewsFound,
              style: TextStyle(color: mainColor),
            ),
          );
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
                  color: backgroundColor, // يعتمد على المود
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color:  Color(0xFFD62828)
                      , width: 2), // قرمزي
                  boxShadow: [
                    BoxShadow(
                     color:  Color(0xFFD62828) ,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (image != null && image.isNotEmpty)
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
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
                      Container(
                        height: 180,
                        decoration: BoxDecoration(
                          color: mainColor.withOpacity(0.1), // إطار أو خلفية خفيفة
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        ),
                      ),

                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color:  Color(0xFFD62828) , // يعتمد على المود
                        ),
                      ),
                    ),

                    if (desc != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: Text(
                          desc!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: subtitleColor, // يعتمد على المود
                            fontSize: 13,
                          ),
                        ),
                      ),

                    const SizedBox(height: 12),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
