import 'dart:convert';

GnewsModel gnewsModelFromJson(String str) => GnewsModel.fromJson(json.decode(str));
String gnewsModelToJson(GnewsModel data) => json.encode(data.toJson());

class GnewsModel {
  final int totalArticles;
  final List<Article> articles;

  GnewsModel({
    required this.totalArticles,
    required this.articles,
  });

  factory GnewsModel.fromJson(Map<String, dynamic> json) => GnewsModel(
    totalArticles: json["totalArticles"],
    articles: List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalArticles": totalArticles,
    "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
  };
}

class Article {
  final String id;
  final String title;
  final String description;
  final String content;
  final String url;
  final String image;
  final DateTime publishedAt;
  final String lang;
  final Source source;

  Article({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.url,
    required this.image,
    required this.publishedAt,
    required this.lang,
    required this.source,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    content: json["content"],
    url: json["url"],
    image: json["image"],
    publishedAt: DateTime.parse(json["publishedAt"]),
    lang: json["lang"],
    source: Source.fromJson(json["source"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "content": content,
    "url": url,
    "image": image,
    "publishedAt": publishedAt.toIso8601String(),
    "lang": lang,
    "source": source.toJson(),
  };
}

class Source {
  final String id;
  final String name;
  final String url;
  final String country;

  Source({
    required this.id,
    required this.name,
    required this.url,
    required this.country,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    id: json["id"],
    name: json["name"],
    url: json["url"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "url": url,
    "country": country,
  };
}
