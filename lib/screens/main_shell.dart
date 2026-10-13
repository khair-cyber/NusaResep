import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'favorite_screen.dart';
import 'home_screen.dart';
import 'recipe_list_screen.dart';

/// Kerangka utama dengan BottomNavigationBar (3 tab).
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomeScreen(onSeeAll: () => setState(() => _index = 1)),
      const RecipeListScreen(),
      const FavoriteScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        selectedItemColor: AppColors.daun,
        unselectedItemColor: AppColors.teksPudar,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: 'Beranda'),
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu_rounded), label: 'Resep'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded), label: 'Favorit'),
        ],
      ),
    );
  }
}
