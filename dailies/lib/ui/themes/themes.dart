import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const double BORDER_RADIUS = 8;
const Color UI_ELEMENTS_BACKGROUND_COLOUR = Color(0xFF8B5CF6);
const APP_FOREGROUND_COLOUR = Color(0xFF1E1E2F);
const Color BOTTOM_NAV_BACKGROUND_COLOR = Color(0xFF1E1E2F);
const Color BOTTOM_NAV_SELECTED_COLOR = Color.fromARGB(255, 192, 137, 255);
const Color BOTTOM_NAV_UNSELECTED_COLOR = Color(0xFF8888AA);
const double BOTTOM_NAV_SELECTED_ICON_SIZE = 28.0;
const double BOTTOM_NAV_UNSELECTED_ICON_SIZE = 24.0;

final ThemeData defaultTheme = ThemeData(
  fontFamily: GoogleFonts.outfit().fontFamily,
  colorScheme: ColorScheme.fromSeed(
    seedColor: APP_FOREGROUND_COLOUR,
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 20,
      fontWeight: FontWeight.w700,
      height: 1.1,
    ),
    headlineMedium: TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.2,
    ),
    bodySmall: TextStyle(
      color: Color(0xFF9CA3AF),
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.3,
    ),
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: Color.fromARGB(120, 37, 37, 53),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: UI_ELEMENTS_BACKGROUND_COLOUR,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BORDER_RADIUS),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF2A2A3C),
    labelStyle: const TextStyle(color: Color(0xFFB8B8C2)),
    hintStyle: const TextStyle(color: Color(0xFF8888AA)),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFF444459)),
      borderRadius: BorderRadius.circular(BORDER_RADIUS),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: UI_ELEMENTS_BACKGROUND_COLOUR,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(BORDER_RADIUS),
    ),
  ),
  scaffoldBackgroundColor: const Color(0xFF121212),
  hoverColor: const Color(0xFF3A3A3C),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: BOTTOM_NAV_BACKGROUND_COLOR,
    selectedItemColor: BOTTOM_NAV_SELECTED_COLOR,
    unselectedItemColor: BOTTOM_NAV_UNSELECTED_COLOR,
    selectedIconTheme: IconThemeData(size: BOTTOM_NAV_SELECTED_ICON_SIZE),
    unselectedIconTheme: IconThemeData(size: BOTTOM_NAV_UNSELECTED_ICON_SIZE),
    showUnselectedLabels: true,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: UI_ELEMENTS_BACKGROUND_COLOUR,
    foregroundColor: Colors.white,
  ),
);
