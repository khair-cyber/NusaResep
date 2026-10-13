import 'package:flutter/material.dart';

import '../data/recipe_repository.dart';
import '../models/recipe.dart';
import '../theme/app_theme.dart';
import '../widgets/favorite_button.dart';
import '../widgets/recipe_image.dart';

/// Pindah ke halaman detail resep dengan Navigator.push.
void openRecipeDetail(BuildContext context, Recipe recipe) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => RecipeDetailScreen(recipe: recipe)),
  );
}

/// Halaman 3: Detail resep (bahan dan langkah memasak).
class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;
  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  final Set<int> _checked = {}; // bahan yang sudah disiapkan

  @override
  Widget build(BuildContext context) {
    final r = widget.recipe;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 240,
            backgroundColor: AppColors.daun,
            foregroundColor: AppColors.teks,
            leading: Padding(
              padding: const EdgeInsets.all(6),
              child: IconButton.filled(
                style: IconButton.styleFrom(backgroundColor: Colors.white),
                color: AppColors.teks,
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(6),
                child: FavoriteButton(recipeId: r.id, onDarkBackground: true),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: RecipeImage(
                recipe: r,
                width: double.infinity,
                height: double.infinity,
                radius: 0,
                emojiSize: 96,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(r.name,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  Text(
                    '${RecipeRepository.instance.categoryName(r.categoryId)} • ${r.region}',
                    style: const TextStyle(color: AppColors.teksPudar),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _InfoTile(
                          icon: Icons.schedule_rounded,
                          value: '${r.duration} mnt',
                          label: 'Waktu'),
                      const SizedBox(width: 10),
                      _InfoTile(
                          icon: Icons.people_alt_rounded,
                          value: '${r.servings}',
                          label: 'Porsi'),
                      const SizedBox(width: 10),
                      _InfoTile(
                          icon: Icons.local_fire_department_rounded,
                          value: r.difficulty,
                          label: 'Tingkat'),
                      const SizedBox(width: 10),
                      _InfoTile(
                          icon: Icons.star_rounded,
                          value: r.rating.toString(),
                          label: 'Rating',
                          iconColor: AppColors.kunyit),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(r.description,
                      style: const TextStyle(height: 1.5, fontSize: 14)),
                  const SizedBox(height: 24),
                  const Text('Bahan-bahan',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  Text('${_checked.length} dari ${r.ingredients.length} bahan siap',
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.teksPudar)),
                  const SizedBox(height: 8),
                  for (var i = 0; i < r.ingredients.length; i++)
                    CheckboxListTile(
                      value: _checked.contains(i),
                      onChanged: (v) => setState(() {
                        v == true ? _checked.add(i) : _checked.remove(i);
                      }),
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: AppColors.daun,
                      title: Text(
                        r.ingredients[i],
                        style: TextStyle(
                          decoration: _checked.contains(i)
                              ? TextDecoration.lineThrough
                              : null,
                          color: _checked.contains(i)
                              ? AppColors.teksPudar
                              : AppColors.teks,
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
                  const Text('Langkah memasak',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 12),
                  for (var i = 0; i < r.steps.length; i++)
                    _StepItem(number: i + 1, text: r.steps[i]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color iconColor;

  const _InfoTile({
    required this.icon,
    required this.value,
    required this.label,
    this.iconColor = AppColors.daun,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20, color: iconColor),
            const SizedBox(height: 4),
            FittedBox(
              child: Text(value,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w700)),
            ),
            Text(label,
                style: const TextStyle(
                    fontSize: 11, color: AppColors.teksPudar)),
          ],
        ),
      ),
    );
  }
}

class _StepItem extends StatelessWidget {
  final int number;
  final String text;
  const _StepItem({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.kunyit,
              shape: BoxShape.circle,
            ),
            child: Text('$number',
                style: const TextStyle(
                    fontWeight: FontWeight.w800, fontSize: 13)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(text, style: const TextStyle(height: 1.5)),
            ),
          ),
        ],
      ),
    );
  }
}
