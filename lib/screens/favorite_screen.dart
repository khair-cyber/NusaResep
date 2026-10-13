import 'package:flutter/material.dart';

import '../data/favorite_store.dart';
import '../data/recipe_repository.dart';
import '../theme/app_theme.dart';
import '../widgets/recipe_card.dart';

/// Halaman 4: Resep favorit pengguna.
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resep favorit',
            style: TextStyle(fontWeight: FontWeight.w800)),
        automaticallyImplyLeading: false,
      ),
      body: ListenableBuilder(
        listenable: FavoriteStore.instance,
        builder: (context, _) {
          final favs = RecipeRepository.instance.recipes
              .where((r) => FavoriteStore.instance.isFavorite(r.id))
              .toList();

          if (favs.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('🤍', style: TextStyle(fontSize: 48)),
                    SizedBox(height: 12),
                    Text('Belum ada resep favorit',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700)),
                    SizedBox(height: 4),
                    Text('Ketuk ikon hati pada resep untuk menyimpannya di sini.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.teksPudar)),
                  ],
                ),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 520,
              mainAxisExtent: 112,
              crossAxisSpacing: 12,
              mainAxisSpacing: 10,
            ),
            itemCount: favs.length,
            itemBuilder: (_, i) => RecipeCard(recipe: favs[i]),
          );
        },
      ),
    );
  }
}
