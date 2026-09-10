import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Typography definitions derived from terrasemillas/DESIGN.md
abstract class AppTypography {
  // Headlines & Titles (Domine Serif)
  static TextStyle displayLg = GoogleFonts.domine(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    height: 48 / 40,
    letterSpacing: -0.8,
    color: AppColors.primary,
  );

  static TextStyle displayMobile = GoogleFonts.domine(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 40 / 32,
    letterSpacing: -0.32,
    color: AppColors.primary,
  );

  static TextStyle headlineLg = GoogleFonts.domine(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 36 / 28,
    letterSpacing: -0.28,
    color: AppColors.primary,
  );

  static TextStyle headlineMd = GoogleFonts.domine(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 30 / 22,
    letterSpacing: 0,
    color: AppColors.primary,
  );

  static TextStyle headlineSm = GoogleFonts.domine(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 24 / 18,
    letterSpacing: 0,
    color: AppColors.primary,
  );

  // Body & Labels (Manrope Sans)
  static TextStyle bodyLg = GoogleFonts.manrope(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 26 / 16,
    letterSpacing: 0,
    color: AppColors.onSurface,
  );

  static TextStyle bodyMd = GoogleFonts.manrope(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 22 / 14,
    letterSpacing: 0,
    color: AppColors.onSurface,
  );

  static TextStyle bodySm = GoogleFonts.manrope(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 18 / 12,
    letterSpacing: 0.12,
    color: AppColors.onSurfaceVariant,
  );

  static TextStyle labelLg = GoogleFonts.manrope(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 20 / 14,
    letterSpacing: 0.28,
    color: AppColors.primary,
  );

  static TextStyle labelMd = GoogleFonts.manrope(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 16 / 12,
    letterSpacing: 0.48,
    color: AppColors.onSurfaceVariant,
  );

  static TextStyle labelSm = GoogleFonts.manrope(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    height: 14 / 10,
    letterSpacing: 0.6,
    color: AppColors.onSurfaceVariant,
  );

  static TextStyle numericMetric = GoogleFonts.manrope(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 24 / 20,
    letterSpacing: -0.2,
    color: AppColors.primary,
  );
}
