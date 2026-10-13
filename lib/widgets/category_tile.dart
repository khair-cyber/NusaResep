import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../theme/app_theme.dart';

class CategoryTile extends StatelessWidget {
  final RecipeCategory category;
  final VoidCallback onTap;
  const CategoryTile({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: SizedBox(
        width: 80,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(category.emoji, style: const TextStyle(fontSize: 26)),
            ),
            const SizedBox(height: 6),
            Text(
              category.name,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: AppColors.teks,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
