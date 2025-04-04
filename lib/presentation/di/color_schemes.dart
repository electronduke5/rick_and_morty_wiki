import 'package:flutter/material.dart';

class ThemeDates {
  static final ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF42A5F5),
      primaryContainer: Color(0xFF1976D2),
      secondary: Color(0xFF26A69A),
      secondaryContainer: Color(0xFF00897B),
      surface: Colors.white,
      error: Color(0xFFD32F2F),
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.black87,
      onError: Colors.white,
      brightness: Brightness.light,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF64B5F6),
      primaryContainer: Color(0xFF42A5F5),
      secondary: Color(0xFF4DB6AC),
      secondaryContainer: Color(0xFF26A69A),
      surface: Color(0xFF2A2828),
      error: Color(0xFFEF5350),
      onPrimary: Colors.black,
      onSecondary: Colors.white,
      onSurface: Colors.white70,
      onError: Colors.black,
      brightness: Brightness.dark,
    ),

  );
}
