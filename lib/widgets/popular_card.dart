import 'package:flutter/material.dart';

import '../data/recipe_repository.dart';
import '../models/recipe.dart';
import '../screens/recipe_detail_screen.dart';
import '../theme/app_theme.dart';
import 'recipe_image.dart';

/// Kartu vertikal untuk carousel "Resep populer".
class PopularCard extends StatelessWidget {
  final Recipe recipe;
  final double width;
  const PopularCard({super.key, required this.recipe, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Material(
        color: AppColors.kartu,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => openRecipeDetail(context, recipe),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: RecipeImage(
                  recipe: recipe,
                  width: double.infinity,
                  radius: 0,
                  emojiSize: 64,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${RecipeRepository.instance.categoryName(recipe.categoryId)} • ${recipe.duration} mnt',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12, color: AppColors.teksPudar),
                          ),
                        ),
                        const Icon(Icons.star_rounded,
                            size: 16, color: AppColors.kunyit),
                        Text(recipe.rating.toString(),
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
