import 'package:expirdate/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  // Headline Styles
  static final TextStyle headline1 = GoogleFonts.cairo(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static final TextStyle headline2 = GoogleFonts.cairo(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static final TextStyle headline3 = GoogleFonts.cairo(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  // Body Text Styles
  static final TextStyle bodyLarge = GoogleFonts.cairo(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static final TextStyle bodyMedium = GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static final TextStyle bodySmall = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: AppColors.textSecondary,
  );

  // Button Text Style
  static final TextStyle button = GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textWhite,
  );

  // Caption / Small Text
  static final TextStyle caption = GoogleFonts.cairo(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: AppColors.textSecondary,
  );
}