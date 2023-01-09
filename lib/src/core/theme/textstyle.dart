import 'package:fintrack/src/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static AppTextStyle instance = AppTextStyle();

  TextStyle displayLarge = GoogleFonts.poppins(
    color: AppColor.white,
    fontSize: 57,
    fontWeight: FontWeight.bold,
  );
  TextStyle displayMedium = GoogleFonts.poppins(
    color: AppColor.white,
    fontSize: 45,
    fontWeight: FontWeight.bold,
  );
  TextStyle displaySmall = GoogleFonts.poppins(
    color: AppColor.white,
    fontSize: 36,
    fontWeight: FontWeight.bold,
  );
  TextStyle headlineLarge = GoogleFonts.poppins(
    color: AppColor.white,
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );
  TextStyle headlineMedium = GoogleFonts.poppins(
    color: AppColor.white,
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );
  TextStyle headlineSmall = GoogleFonts.poppins(
    color: AppColor.white,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
  TextStyle titleLarge = GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    color: AppColor.white,
    fontSize: 22,
  );
  TextStyle titleMedium = GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    color: AppColor.white,
    fontSize: 18,
  );
  TextStyle titleSmall = GoogleFonts.poppins(
    color: AppColor.white,
    fontSize: 14,
  );
  TextStyle labelLarge = GoogleFonts.poppins(
    color: AppColor.white,
    fontSize: 14,
  );
  TextStyle labelMedium = GoogleFonts.poppins(
    color: AppColor.white,
    fontSize: 12,
  );
  TextStyle labelSmall = GoogleFonts.poppins(
    color: AppColor.white,
    fontSize: 11,
  );
  TextStyle bodyLarge = GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    color: AppColor.white,
    fontSize: 16,
  );
  TextStyle bodyMedium = GoogleFonts.poppins(
    color: AppColor.white,
    fontSize: 14,
  );
  TextStyle bodySmall = GoogleFonts.poppins(
    color: AppColor.white,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
}
