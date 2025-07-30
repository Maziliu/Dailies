import 'package:flutter/material.dart';

const double BORDER_RADIUS = 8;

final ThemeData defaultTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF1E1E2F),
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(color: Color(0xFFA479D9)),
    headlineSmall: TextStyle(color: Color(0xFFBB86FC)),
    bodyLarge: TextStyle(color: Color(0xFFBB86FC)),
    bodySmall: TextStyle(color: Color(0xFFA0A0B0)),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1E1E2F),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFA479D9),
      foregroundColor: const Color(0xFF1E1E2F),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BORDER_RADIUS),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF2A2A3C),
    labelStyle: const TextStyle(color: Color(0xFFA479D9)),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFBB86FC)),
      borderRadius: BorderRadius.circular(BORDER_RADIUS),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFA479D9), width: 2),
      borderRadius: BorderRadius.circular(BORDER_RADIUS),
    ),
  ),
  scaffoldBackgroundColor: const Color(0xFF121212),
  cardTheme: CardTheme(
    color: const Color(0xFF333340),
    elevation: 6,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(BORDER_RADIUS),
    ),
    shadowColor: Colors.black,
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    surfaceTintColor: Colors.transparent,
  ),
  hoverColor: const Color(0xFF2A2A3C),
);
