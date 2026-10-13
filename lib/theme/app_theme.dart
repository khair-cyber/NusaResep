import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Palet warna bertema bahan dapur Nusantara.
class AppColors {
  static const daun = Color(0xFF1F4D3A); // daun pisang (utama)
  static const kunyit = Color(0xFFF2B134); // kunyit (aksen)
  static const cabai = Color(0xFFD7263D); // cabai (favorit/peringatan)
  static const latar = Color(0xFFF3F6F1); // latar halaman
  static const teks = Color(0xFF1B2A24);
  static const teksPudar = Color(0xFF6B7A72);
  static const kartu = Colors.white;
}

ThemeData buildAppTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.daun,
      primary: AppColors.daun,
      secondary: AppColors.kunyit,
      surface: AppColors.kartu,
    ),
    scaffoldBackgroundColor: AppColors.latar,
  );

  return base.copyWith(
    textTheme: GoogleFonts.plusJakartaSansTextTheme(base.textTheme).apply(
      bodyColor: AppColors.teks,
      displayColor: AppColors.teks,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.daun,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.white,
      selectedColor: AppColors.daun,
      labelStyle: const TextStyle(fontWeight: FontWeight.w600),
      secondaryLabelStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      checkmarkColor: Colors.white,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}
