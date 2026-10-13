import 'package:flutter/material.dart';

import '../data/favorite_store.dart';
import '../theme/app_theme.dart';

class FavoriteButton extends StatelessWidget {
  final int recipeId;
  final bool onDarkBackground;

  const FavoriteButton({
    super.key,
    required this.recipeId,
    this.onDarkBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: FavoriteStore.instance,
      builder: (context, _) {
        final fav = FavoriteStore.instance.isFavorite(recipeId);
        return IconButton(
          tooltip: fav ? 'Hapus dari favorit' : 'Simpan ke favorit',
          onPressed: () => FavoriteStore.instance.toggle(recipeId),
          style: onDarkBackground
              ? IconButton.styleFrom(backgroundColor: Colors.white)
              : null,
          icon: Icon(
            fav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            color: fav ? AppColors.cabai : AppColors.teksPudar,
          ),
        );
      },
    );
  }
}
