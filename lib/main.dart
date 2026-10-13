import 'package:flutter/material.dart';

import 'data/recipe_repository.dart';
import 'screens/main_shell.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Muat data dummy dari assets/data/recipes.json sebelum aplikasi tampil.
  await RecipeRepository.instance.load();
  runApp(const NusaResepApp());
}

class NusaResepApp extends StatelessWidget {
  const NusaResepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NusaResep',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const MainShell(),
    );
  }
}
