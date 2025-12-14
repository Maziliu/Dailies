import 'package:dailies_v2/ui/theme/colour_schemes.dart';
import 'package:dailies_v2/ui/theme/standards.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      fontFamily: GoogleFonts.outfit().fontFamily,

      scaffoldBackgroundColor: darkColorScheme.surface,

      textTheme: TextTheme(
        headlineLarge: TextStyle(
          color: darkColorScheme.onSurface,
          fontSize: HEADLINE_LARGE,
          fontWeight: HEADLINE_LARGE_WEIGHT,
        ),
        headlineMedium: TextStyle(
          color: darkColorScheme.onSurface,
          fontSize: HEADLINE_MEDIUM,
          fontWeight: HEADLINE_MEDIUM_WEIGHT,
        ),
        bodySmall: TextStyle(
          color: darkColorScheme.onSurface.withAlpha(SECONDARY_TEXT_ALPHA),
          fontSize: BODY_SMALL,
          fontWeight: BODY_SMALL_WEIGHT,
        ),
      ),

      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: darkColorScheme.surface.withAlpha(
          APP_BAR_SURFACE_ALPHA,
        ),
        foregroundColor: darkColorScheme.onSurface,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkColorScheme.primary,
          foregroundColor: darkColorScheme.onPrimary,
          padding: FAB_BUTTON_PADDING,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BORDER_RADIUS),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkColorScheme.surface,
        labelStyle: TextStyle(
          color: darkColorScheme.onSurface.withAlpha(SECONDARY_TEXT_ALPHA),
        ),
        hintStyle: TextStyle(
          color: darkColorScheme.onSurface.withAlpha(TERTIARY_TEXT_ALPHA),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: darkColorScheme.outline),
          borderRadius: BorderRadius.circular(BORDER_RADIUS),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: darkColorScheme.primary, width: 2),
          borderRadius: BorderRadius.circular(BORDER_RADIUS),
        ),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: darkColorScheme.surface,
        selectedItemColor: darkColorScheme.secondary,
        unselectedItemColor: darkColorScheme.onSurface.withAlpha(
          SECONDARY_TEXT_ALPHA,
        ),
        selectedIconTheme: const IconThemeData(
          size: NAV_NAR_SELECTED_ICON_SIZE,
        ),
        unselectedIconTheme: const IconThemeData(
          size: NAV_BAR_UNSELECTED_ICON_SIZE,
        ),
        showUnselectedLabels: true,
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: darkColorScheme.primary,
        foregroundColor: darkColorScheme.onPrimary,
      ),
    );
  }
}
