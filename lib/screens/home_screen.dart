import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../data/recipe_repository.dart';
import '../theme/app_theme.dart';
import '../widgets/category_tile.dart';
import '../widgets/popular_card.dart';
import '../widgets/recipe_card.dart';
import 'recipe_list_screen.dart';

/// Halaman 1: Beranda.
class HomeScreen extends StatelessWidget {
  final VoidCallback onSeeAll;
  const HomeScreen({super.key, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    final repo = RecipeRepository.instance;
    final width = MediaQuery.of(context).size.width;
    // Lebar kartu populer menyesuaikan layar (responsif).
    final popularWidth = math.min(260.0, width * 0.68);

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _Header(),
        const SizedBox(height: 20),
        _SectionTitle(title: 'Kategori'),
        const SizedBox(height: 12),
        SizedBox(
          height: 98,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: repo.categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final c = repo.categories[i];
              return CategoryTile(
                category: c,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RecipeListScreen(
                      initialCategoryId: c.id,
                      title: c.name,
                      showBack: true,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        _SectionTitle(title: 'Resep populer'),
        const SizedBox(height: 12),
        SizedBox(
          height: 230,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: repo.popular.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, i) =>
                PopularCard(recipe: repo.popular[i], width: popularWidth),
          ),
        ),
        const SizedBox(height: 24),
        _SectionTitle(
            title: 'Baru ditambahkan', actionLabel: 'Lihat semua', onAction: onSeeAll),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              for (final r in repo.latest) ...[
                RecipeCard(recipe: r),
                const SizedBox(height: 10),
              ],
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
      decoration: const BoxDecoration(
        color: AppColors.daun,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Mau masak apa hari ini?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.kunyit,
                    shape: BoxShape.circle,
                  ),
                  child: const Text('🍳', style: TextStyle(fontSize: 22)),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'Temukan resep masakan dari seluruh Nusantara.',
              style: TextStyle(color: Color(0xB3FFFFFF), fontSize: 13),
            ),
            const SizedBox(height: 18),
            TextField(
              textInputAction: TextInputAction.search,
              onSubmitted: (value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RecipeListScreen(
                    initialQuery: value,
                    title: 'Hasil pencarian',
                    showBack: true,
                  ),
                ),
              ),
              decoration: InputDecoration(
                hintText: 'Cari rendang, soto, atau bahan...',
                hintStyle: const TextStyle(fontSize: 14),
                prefixIcon: const Icon(Icons.search_rounded),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;
  const _SectionTitle({required this.title, this.actionLabel, this.onAction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w800)),
          ),
          if (actionLabel != null)
            TextButton(
              onPressed: onAction,
              child: Text(actionLabel!,
                  style: const TextStyle(fontWeight: FontWeight.w700)),
            ),
        ],
      ),
    );
  }
}
