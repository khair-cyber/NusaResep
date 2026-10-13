import 'package:flutter/material.dart';

import '../data/recipe_repository.dart';
import '../theme/app_theme.dart';
import '../widgets/recipe_card.dart';

/// Halaman 2: Daftar resep dengan pencarian dan filter kategori.
/// Dipakai sebagai tab "Resep" dan sebagai halaman hasil dari Beranda.
class RecipeListScreen extends StatefulWidget {
  final String? initialCategoryId;
  final String initialQuery;
  final String title;
  final bool showBack;

  const RecipeListScreen({
    super.key,
    this.initialCategoryId,
    this.initialQuery = '',
    this.title = 'Daftar resep',
    this.showBack = false,
  });

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  late final TextEditingController _controller;
  String? _categoryId;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery);
    _categoryId = widget.initialCategoryId;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repo = RecipeRepository.instance;
    final results =
        repo.search(query: _controller.text, categoryId: _categoryId);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
            style: const TextStyle(fontWeight: FontWeight.w800)),
        automaticallyImplyLeading: widget.showBack,
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.daun,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
            child: TextField(
              controller: _controller,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Cari resep atau bahan',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _controller.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () => setState(_controller.clear),
                      ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 56,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              children: [
                _chip('Semua', null),
                for (final c in repo.categories) _chip(c.name, c.id),
              ],
            ),
          ),
          Expanded(
            child: results.isEmpty
                ? const _EmptyState()
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                    // 1 kolom di ponsel, 2+ kolom di layar lebar/tablet.
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 520,
                      mainAxisExtent: 112,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: results.length,
                    itemBuilder: (_, i) => RecipeCard(recipe: results[i]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String label, String? id) {
    final selected = _categoryId == id;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        labelStyle: TextStyle(
          color: selected ? Colors.white : AppColors.teks,
          fontWeight: FontWeight.w600,
        ),
        showCheckmark: false,
        onSelected: (_) => setState(() => _categoryId = id),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('🔍', style: TextStyle(fontSize: 48)),
            SizedBox(height: 12),
            Text('Resep tidak ditemukan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            SizedBox(height: 4),
            Text('Coba kata kunci lain atau pilih kategori Semua.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.teksPudar)),
          ],
        ),
      ),
    );
  }
}
