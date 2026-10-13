import 'package:flutter/material.dart';

import '../data/recipe_repository.dart';
import '../models/recipe.dart';
import '../screens/recipe_detail_screen.dart';
import '../theme/app_theme.dart';
import 'favorite_button.dart';
import 'recipe_image.dart';

/// Kartu horizontal (gambar di kiri) untuk daftar resep. Tinggi tetap 112.
class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 112,
      child: Material(
        color: AppColors.kartu,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => openRecipeDetail(context, recipe),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                RecipeImage(recipe: recipe, width: 88, height: 88, emojiSize: 36),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        recipe.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${RecipeRepository.instance.categoryName(recipe.categoryId)} • ${recipe.region}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.teksPudar,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.schedule_rounded,
                              size: 15, color: AppColors.teksPudar),
                          const SizedBox(width: 4),
                          Text('${recipe.duration} mnt',
                              style: const TextStyle(fontSize: 12)),
                          const SizedBox(width: 12),
                          const Icon(Icons.star_rounded,
                              size: 16, color: AppColors.kunyit),
                          const SizedBox(width: 2),
                          Text(recipe.rating.toString(),
                              style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
                FavoriteButton(recipeId: recipe.id),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
