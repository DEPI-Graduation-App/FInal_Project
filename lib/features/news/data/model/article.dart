import 'package:flutter/foundation.dart';

@immutable
class Article {
  final String id;
  final String title;
  final String? description;
  final String? imageUrl;
  final String sourceName;
  final String articleUrl;
  final DateTime publishedAt;
  final String? author;

  final String? content;
  final String? contentEn;
  final String? contentAr;
  final List<ArticleSource>? sources;
  final bool isAiGenerated;

  const Article({
    required this.id,
    required this.title,
    this.description,
    this.imageUrl,
    required this.sourceName,
    required this.articleUrl,
    required this.publishedAt,
    this.author,
    this.content,
    this.contentEn,
    this.contentAr,
    this.sources,
    this.isAiGenerated = false,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'],
      imageUrl: json['imageUrl'],
      sourceName: json['sourceName'] ?? '',
      articleUrl: json['articleUrl'] ?? '',
      publishedAt: DateTime.parse(json['publishedAt']),
      author: json['author'],
      content: json['content'],
      contentEn: json['contentEn'],
      contentAr: json['contentAr'],
      sources: (json['sources'] as List<dynamic>?)
          ?.map((e) => ArticleSource.fromJson(e))
          .toList(),
      isAiGenerated: json['isAiGenerated'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'sourceName': sourceName,
      'articleUrl': articleUrl,
      'publishedAt': publishedAt.toIso8601String(),
      'author': author,
      'content': content,
      'contentEn': contentEn,
      'contentAr': contentAr,
      'sources': sources?.map((e) => e.toJson()).toList(),
      'isAiGenerated': isAiGenerated,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Article && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  Article copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? sourceName,
    String? articleUrl,
    DateTime? publishedAt,
    String? author,
    String? content,
    String? contentEn,
    String? contentAr,
    List<ArticleSource>? sources,
    bool? isAiGenerated,
  }) {
    return Article(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      sourceName: sourceName ?? this.sourceName,
      articleUrl: articleUrl ?? this.articleUrl,
      publishedAt: publishedAt ?? this.publishedAt,
      author: author ?? this.author,
      content: content ?? this.content,
      contentEn: contentEn ?? this.contentEn,
      contentAr: contentAr ?? this.contentAr,
      sources: sources ?? this.sources,
      isAiGenerated: isAiGenerated ?? this.isAiGenerated,
    );
  }
}

class ArticleSource {
  final String name;
  final String url;

  ArticleSource({required this.name, required this.url});

  factory ArticleSource.fromJson(Map<String, dynamic> json) {
    return ArticleSource(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'url': url};
  }
}
