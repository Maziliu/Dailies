import 'package:flutter/material.dart';

class UIFormating {
  static const double _smallPadding = 8, _mediumPadding = 16, _largePadding = 24, _extraLargePadding = 32;
  static const double _smallVerticalSpacing = 8, _mediumVerticalSpacing = 16, _largeVerticalSpacing = 24, _extraLargeVerticalSpacing = 32;
  static const double _smallBorderRadius = 8, _mediumBorderRadius = 16, _largeBorderRadius = 24, _extraLargeBorderRadius = 32;

  static EdgeInsetsGeometry smallPadding() => const EdgeInsets.all(_smallPadding);
  static EdgeInsetsGeometry mediumPadding() => const EdgeInsets.all(_mediumPadding);
  static EdgeInsetsGeometry largePadding() => const EdgeInsets.all(_largePadding);
  static EdgeInsetsGeometry extraLargePadding() => const EdgeInsets.all(_extraLargePadding);

  static SizedBox smallVerticalSpacing() => const SizedBox(height: _smallVerticalSpacing);
  static SizedBox mediumVerticalSpacing() => const SizedBox(height: _mediumVerticalSpacing);
  static SizedBox largeVerticalSpacing() => const SizedBox(height: _largeVerticalSpacing);
  static SizedBox extraLargeVerticalSpacing() => const SizedBox(height: _extraLargeVerticalSpacing);

  static BorderRadius smallCircularBorderRadius() => BorderRadius.circular(_smallBorderRadius);
  static BorderRadius mediumCircularBorderRadius() => BorderRadius.circular(_mediumBorderRadius);
  static BorderRadius largeCircularBorderRadius() => BorderRadius.circular(_largeBorderRadius);
  static BorderRadius extraLargeCircularBorderRadius() => BorderRadius.circular(_extraLargeBorderRadius);
}
