import 'package:flutter/material.dart';

class AppTheme {
  static const Color deepBlue = Color(0xFF0A66C2);
  static const Color lightBlue = Color(0xFF68B3FF);
  static const Color paleBlue = Color(0xFFE6F2FF);
  static const Color softGrey = Color(0xFFF5F7FA);
  static ThemeData get lightTheme => ThemeData.light();
  static ThemeData get darkTheme => ThemeData.dark();
  static ThemeData get theme {
    final scheme = ColorScheme.fromSeed(
      seedColor: deepBlue,
      primary: deepBlue,
      secondary: lightBlue,
      background: softGrey,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: softGrey,
      appBarTheme: const AppBarTheme(
        backgroundColor: deepBlue,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 2,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        hintStyle: const TextStyle(color: Colors.black45),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    );
  }
}
