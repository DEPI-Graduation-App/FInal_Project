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
}
