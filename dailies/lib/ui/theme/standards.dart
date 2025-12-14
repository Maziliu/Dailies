import 'package:flutter/material.dart';

/// Shape
const double BORDER_RADIUS = 8.0;

/// Icon sizes
const double NAV_NAR_SELECTED_ICON_SIZE = 28.0;
const double NAV_BAR_UNSELECTED_ICON_SIZE = 24.0;

/// Typography sizes
const double HEADLINE_LARGE = 20.0;
const double HEADLINE_MEDIUM = 16.0;
const double BODY_SMALL = 12.0;

/// Typography weights
const FontWeight HEADLINE_LARGE_WEIGHT = FontWeight.w700;
const FontWeight HEADLINE_MEDIUM_WEIGHT = FontWeight.w600;
const FontWeight BODY_SMALL_WEIGHT = FontWeight.w500;

/// Padding
const EdgeInsets FAB_BUTTON_PADDING = EdgeInsets.symmetric(
  horizontal: 16,
  vertical: 12,
);

/// Alpha values
const int SECONDARY_TEXT_ALPHA = 180; // ~70%
const int TERTIARY_TEXT_ALPHA = 128; // ~50%
const int APP_BAR_SURFACE_ALPHA = 230; // ~90%


class UIFormating {
  static const double _small = 8, _medium = 16, _large = 24, _extraLarge = 32;

  static EdgeInsetsGeometry smallPadding() => const EdgeInsets.all(_small);
  static EdgeInsetsGeometry mediumPadding() => const EdgeInsets.all(_medium);
  static EdgeInsetsGeometry largePadding() => const EdgeInsets.all(_large);
  static EdgeInsetsGeometry extraLargePadding() =>
      const EdgeInsets.all(_extraLarge);

  static SizedBox smallVerticalSpacing() => const SizedBox(height: _small);
  static SizedBox mediumVerticalSpacing() => const SizedBox(height: _medium);
  static SizedBox largeVerticalSpacing() => const SizedBox(height: _large);
  static SizedBox extraLargeVerticalSpacing() =>
      const SizedBox(height: _extraLarge);

  static SizedBox smallHorizontalSpacing() => const SizedBox(width: _small);
  static SizedBox mediumHorizontalSpacing() => const SizedBox(width: _medium);
  static SizedBox largeHorizontalSpacing() => const SizedBox(width: _large);
  static SizedBox extraLargeHorizontalSpacing() =>
      const SizedBox(width: _extraLarge);

  static BorderRadius smallCircularBorderRadius() =>
      BorderRadius.circular(_small);
  static BorderRadius mediumCircularBorderRadius() =>
      BorderRadius.circular(_medium);
  static BorderRadius largeCircularBorderRadius() =>
      BorderRadius.circular(_large);
  static BorderRadius extraLargeCircularBorderRadius() =>
      BorderRadius.circular(_extraLarge);
}
