import 'package:flutter/material.dart';

import '../models/recipe.dart';

/// Gambar resep. Jika [Recipe.imageUrl] kosong atau gagal dimuat (mis. offline),
/// ditampilkan blok berwarna dengan emoji sebagai pengganti.
class RecipeImage extends StatelessWidget {
  final Recipe recipe;
  final double? width;
  final double? height;
  final double radius;
  final double emojiSize;

  const RecipeImage({
    super.key,
    required this.recipe,
    this.width,
    this.height,
    this.radius = 14,
    this.emojiSize = 40,
  });

  @override
  Widget build(BuildContext context) {
    final fallback = Container(
      width: width,
      height: height,
      color: recipe.color,
      alignment: Alignment.center,
      child: Text(recipe.emoji, style: TextStyle(fontSize: emojiSize)),
    );

    final url = recipe.imageUrl;
    final Widget child = (url == null || url.isEmpty)
        ? fallback
        : Image.network(
            url,
            width: width,
            height: height,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => fallback,
            loadingBuilder: (context, img, progress) =>
                progress == null ? img : fallback,
          );

    return ClipRRect(borderRadius: BorderRadius.circular(radius), child: child);
  }
}
