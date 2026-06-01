import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const bgPage = Color(0xFFF0F2F5);
  static const bgSidebar = Color(0xFF1A1F2E);
  static const bgCard = Color(0xFFFFFFFF);
  static const bgNavActive = Color(0xFF2D3A5C);

  static const textPrimary = Color(0xFF1E293B);
  static const textHeading = Color(0xFF0F172A);
  static const textDescription = Color(0xFF334155);
  static const textParagraph = Color(0xFF64748B);
  static const radioSelectedBg = Color(0xFFF8F9FF);
  static const textSecondary = Color(0xFF475569);
  static const textMuted = Color(0xFF94A3B8);
  static const textSidebar = Color(0xFFCBD5E1);
  static const textSidebarSection = Color(0xFF94A3B8);

  static const brandPrimary = Color(0xFF3B4FE0);
  static const brandBlue = Color(0xFF5B6AF0);
  static const brandPrimaryLight = Color(0xFF7B8FF5);
  static const brandAccent = Color(0xFFF05B6A);

  static const border = Color(0xFFE4E8F0);
  static const borderLight = Color(0xFFE2E8F0);
  static const white = Color(0xFFFFFFFF);
  static const infoBg = Color(0xFFF0F9FF);
  static const infoBorder = Color(0xFFBAE6FD);

  static const requiredRed = Color(0xFFEF4444);

  static const shadow = Color(0x0F000000);
}

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: false,
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: AppColors.bgPage,
      colorScheme: const ColorScheme.light(
        primary: AppColors.brandPrimary,
        secondary: AppColors.brandAccent,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: AppColors.textHeading,
          fontSize: 26,
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: TextStyle(
          color: AppColors.textHeading,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
        titleLarge: TextStyle(
          color: AppColors.textHeading,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14,
        ),
        bodySmall: TextStyle(
          color: AppColors.textMuted,
          fontSize: 12,
        ),
        labelLarge: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.brandPrimary,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.brandPrimary, width: 2),
        ),
        filled: true,
        fillColor: AppColors.white,
      ),
    );
  }
}
