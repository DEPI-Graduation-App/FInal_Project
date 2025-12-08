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
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      sourceName: json['sourceName'] as String,
      articleUrl: json['articleUrl'] as String,
      publishedAt: DateTime.parse(json['publishedAt'] as String),
      author: json['author'] as String?,
      content: json['content'] as String?,
      contentEn: json['contentEn'] as String?,
      contentAr: json['contentAr'] as String?,
      sources: (json['sources'] as List<dynamic>?)
          ?.map((e) => ArticleSource.fromJson(e as Map<String, dynamic>))
          .toList(),
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
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Article && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
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
