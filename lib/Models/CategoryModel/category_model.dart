// lib/Models/Category.dart
import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final String? imageUrl; // optional asset path or network url
  final String? icon; // optional text/icon name
  final Color? color;

  Category({
    required this.id,
    required this.name,
    this.imageUrl,
    this.icon,
    this.color,
  });
}
