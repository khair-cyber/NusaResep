import 'package:flutter/material.dart';

/// Kategori resep (mis. Hidangan Utama, Sup & Soto).
class RecipeCategory {
  final String id;
  final String name;
  final String emoji;

  const RecipeCategory({
    required this.id,
    required this.name,
    required this.emoji,
  });

  factory RecipeCategory.fromJson(Map<String, dynamic> json) {
    return RecipeCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      emoji: json['emoji'] as String,
    );
  }
}

/// Model resep. Struktur JSON sengaja dibuat sama dengan bentuk respons API
/// agar nanti cukup mengganti sumber data (asset -> HTTP) tanpa mengubah UI.
class Recipe {
  final int id;
  final String name;
  final String categoryId;
  final String region;
  final String emoji;
  final String colorHex;
  final String? imageUrl;
  final int duration; // menit
  final int servings; // porsi
  final String difficulty;
  final double rating;
  final String description;
  final List<String> ingredients;
  final List<String> steps;

  const Recipe({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.region,
    required this.emoji,
    required this.colorHex,
    required this.imageUrl,
    required this.duration,
    required this.servings,
    required this.difficulty,
    required this.rating,
    required this.description,
    required this.ingredients,
    required this.steps,
  });

  /// Warna latar kartu/gambar, dibaca dari kode hex di JSON.
  Color get color {
    final hex = colorHex.replaceAll('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as int,
      name: json['name'] as String,
      categoryId: json['categoryId'] as String,
      region: json['region'] as String,
      emoji: json['emoji'] as String,
      colorHex: json['colorHex'] as String,
      imageUrl: json['imageUrl'] as String?,
      duration: json['duration'] as int,
      servings: json['servings'] as int,
      difficulty: json['difficulty'] as String,
      rating: (json['rating'] as num).toDouble(),
      description: json['description'] as String,
      ingredients: List<String>.from(json['ingredients'] as List),
      steps: List<String>.from(json['steps'] as List),
    );
  }
}
