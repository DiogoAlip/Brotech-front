import 'package:flutter/material.dart';

/// Design tokens derived from terrasemillas/DESIGN.md
abstract class AppColors {
  // Primary Palette
  static const Color primary = Color(0xFF002921); // Deep heritage forest green
  static const Color primaryContainer = Color(0xFF114036);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFF7EAC9E);
  static const Color inversePrimary = Color(0xFFA2D0C2);

  // Secondary Palette
  static const Color secondary = Color(0xFF006B54); // Botanical emerald green
  static const Color secondaryAccent = Color(0xFF16AF8B);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFF75F6CE);
  static const Color secondaryFixedDim = Color(0xFF75F6CE);
  static const Color onSecondaryContainer = Color(0xFF007058);

  // Tertiary Palette (Golden Harvest)
  static const Color tertiary = Color(0xFF322000);
  static const Color tertiaryContainer = Color(0xFF4E3400);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color onTertiaryContainer = Color(0xFFD4971E);
  static const Color tertiaryFixedDim = Color(0xFFFDBB42);
  static const Color tertiaryFixed = Color(0xFFFFDEAD);

  // Neutral Surfaces & Canvas
  static const Color surface = Color(0xFFFFF9E6); // Warm organic parchment
  static const Color surfaceDim = Color(0xFFE0DAC1);
  static const Color surfaceBright = Color(0xFFFFF9E6);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFFAF4DA);
  static const Color surfaceContainer = Color(0xFFF4EED4);
  static const Color surfaceContainerHigh = Color(0xFFEEE8CF);
  static const Color surfaceContainerHighest = Color(0xFFE9E3C9);
  static const Color onSurface = Color(0xFF1E1C0C);
  static const Color onSurfaceVariant = Color(0xFF404846);
  static const Color outline = Color(0xFF717975);
  static const Color outlineVariant = Color(0xFFC0C8C4);

  // Error & Status
  static const Color error = Color(0xFFBA1A1A);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onError = Color(0xFFFFFFFF);
}
