import 'package:flutter/material.dart';

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
