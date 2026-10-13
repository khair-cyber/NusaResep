import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/recipe.dart';

/// Sumber data tunggal untuk seluruh halaman.
///
/// Tahap sekarang : membaca file JSON lokal (assets/data/recipes.json).
/// Tahap lanjutan : ganti isi [load] dengan permintaan HTTP ke API, misalnya
///   final res = await http.get(Uri.parse('https://api.example.com/recipes'));
///   final json = jsonDecode(res.body) as Map<String, dynamic>;
/// Karena bentuk JSON-nya sama, halaman UI tidak perlu diubah.
class RecipeRepository {
  RecipeRepository._();
  static final RecipeRepository instance = RecipeRepository._();

  List<RecipeCategory> categories = [];
  List<Recipe> recipes = [];

  Future<void> load() async {
    final raw = await rootBundle.loadString('assets/data/recipes.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    categories = (json['categories'] as List)
        .map((e) => RecipeCategory.fromJson(e as Map<String, dynamic>))
        .toList();
    recipes = (json['recipes'] as List)
        .map((e) => Recipe.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  String categoryName(String id) {
    for (final c in categories) {
      if (c.id == id) return c.name;
    }
    return id;
  }

  /// Resep dengan rating tinggi, diurutkan dari yang tertinggi.
  List<Recipe> get popular {
    final list = recipes.where((r) => r.rating >= 4.7).toList()
      ..sort((a, b) => b.rating.compareTo(a.rating));
    return list;
  }

  /// Lima resep terakhir yang ditambahkan (id terbesar).
  List<Recipe> get latest {
    final list = recipes.toList()..sort((a, b) => b.id.compareTo(a.id));
    return list.take(5).toList();
  }

  List<Recipe> search({String query = '', String? categoryId}) {
    final q = query.trim().toLowerCase();
    return recipes.where((r) {
      final matchCategory = categoryId == null || r.categoryId == categoryId;
      final matchQuery = q.isEmpty ||
          r.name.toLowerCase().contains(q) ||
          r.region.toLowerCase().contains(q) ||
          r.ingredients.any((i) => i.toLowerCase().contains(q));
      return matchCategory && matchQuery;
    }).toList();
  }
}
