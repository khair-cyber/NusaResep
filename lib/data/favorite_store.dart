import 'package:flutter/foundation.dart';

/// Menyimpan id resep favorit selama aplikasi berjalan.
/// Memakai ChangeNotifier agar semua halaman ikut diperbarui saat berubah.
class FavoriteStore extends ChangeNotifier {
  FavoriteStore._();
  static final FavoriteStore instance = FavoriteStore._();

  final Set<int> _ids = {};

  Set<int> get ids => Set.unmodifiable(_ids);

  bool isFavorite(int id) => _ids.contains(id);

  void toggle(int id) {
    if (!_ids.remove(id)) _ids.add(id);
    notifyListeners();
  }
}
