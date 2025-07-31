import 'package:flutter/material.dart';

const double BORDER_RADIUS = 8;

const Color UI_ELEMENTS_BACKGROUND_COLOUR = Color(0xFF5F6AC4);
const APP_FOREGROUND_COLOUR = Color(0xFF1E1E2F);

const Color BOTTOM_NAV_BACKGROUND_COLOR = Color(0xFF1E1E2F);
const Color BOTTOM_NAV_SELECTED_COLOR = UI_ELEMENTS_BACKGROUND_COLOUR;
const Color BOTTOM_NAV_UNSELECTED_COLOR = Color(0xFF8888AA);
const double BOTTOM_NAV_SELECTED_ICON_SIZE = 28.0;
const double BOTTOM_NAV_UNSELECTED_ICON_SIZE = 24.0;

final ThemeData defaultTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: APP_FOREGROUND_COLOUR, brightness: Brightness.dark),
  useMaterial3: true,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(color: UI_ELEMENTS_BACKGROUND_COLOUR),
    headlineSmall: TextStyle(color: Color(0xFFBB86FC)),
    bodyLarge: TextStyle(color: Color(0xFFBB86FC)),
    bodySmall: TextStyle(color: Color(0xFFA0A0B0)),
  ),
  appBarTheme: const AppBarTheme(backgroundColor: APP_FOREGROUND_COLOUR, foregroundColor: Colors.white, elevation: 0),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: UI_ELEMENTS_BACKGROUND_COLOUR,
      foregroundColor: APP_FOREGROUND_COLOUR,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(BORDER_RADIUS)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF2A2A3C),
    labelStyle: const TextStyle(color: UI_ELEMENTS_BACKGROUND_COLOUR),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFBB86FC)),
      borderRadius: BorderRadius.circular(BORDER_RADIUS),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: UI_ELEMENTS_BACKGROUND_COLOUR, width: 2),
      borderRadius: BorderRadius.circular(BORDER_RADIUS),
    ),
  ),
  scaffoldBackgroundColor: const Color(0xFF121212),
  cardTheme: CardTheme(
    color: const Color(0xFF333340),
    elevation: 6,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(BORDER_RADIUS)),
    shadowColor: Colors.black,
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    surfaceTintColor: Colors.transparent,
  ),
  hoverColor: const Color(0xFF2A2A3C),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: BOTTOM_NAV_BACKGROUND_COLOR,
    selectedItemColor: BOTTOM_NAV_SELECTED_COLOR,
    unselectedItemColor: BOTTOM_NAV_UNSELECTED_COLOR,
    selectedIconTheme: IconThemeData(size: BOTTOM_NAV_SELECTED_ICON_SIZE),
    unselectedIconTheme: IconThemeData(size: BOTTOM_NAV_UNSELECTED_ICON_SIZE),
    showUnselectedLabels: true,
  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: UI_ELEMENTS_BACKGROUND_COLOUR),
);
