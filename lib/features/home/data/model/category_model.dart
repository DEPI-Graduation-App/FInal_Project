import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final String? imageUrl;
  final String? icon;
  final Color? color;

  Category({
    required this.id,
    required this.name,
    this.imageUrl,
    this.icon,
    this.color,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'icon': icon,
    'imageUrl': imageUrl,
  };

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['id'],
    name: json['name'],
    icon: json['icon'],
    imageUrl: json['imageUrl'],
  );
}
