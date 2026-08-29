import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Tema global do aplicativo (Material Design 3).
///
/// Define paleta, tipografia (Nunito para títulos, Inter para corpo) e o
/// estilo padrão dos componentes reutilizados nas telas.
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Inter',
      textTheme: _textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textStrong,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w800,
          fontSize: 20,
          color: AppColors.textStrong,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.border),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: const TextStyle(color: AppColors.textSoft, fontSize: 14),
        border: _inputBorder(AppColors.border),
        enabledBorder: _inputBorder(AppColors.border),
        focusedBorder: _inputBorder(AppColors.primary, width: 1.6),
        errorBorder: _inputBorder(AppColors.danger),
        focusedErrorBorder: _inputBorder(AppColors.danger, width: 1.6),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surface,
        side: const BorderSide(color: AppColors.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        labelStyle: const TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: AppColors.textMuted,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSoft,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  static OutlineInputBorder _inputBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  static const TextTheme _textTheme = TextTheme(
    displaySmall: TextStyle(
      fontFamily: 'Nunito',
      fontWeight: FontWeight.w800,
      color: AppColors.textStrong,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Nunito',
      fontWeight: FontWeight.w800,
      color: AppColors.textStrong,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Nunito',
      fontWeight: FontWeight.w800,
      color: AppColors.textStrong,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Nunito',
      fontWeight: FontWeight.w800,
      color: AppColors.textStrong,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Nunito',
      fontWeight: FontWeight.w700,
      color: AppColors.textStrong,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Nunito',
      fontWeight: FontWeight.w700,
      color: AppColors.textStrong,
    ),
    bodyLarge: TextStyle(fontFamily: 'Inter', color: AppColors.textMuted),
    bodyMedium: TextStyle(fontFamily: 'Inter', color: AppColors.textMuted),
    bodySmall: TextStyle(fontFamily: 'Inter', color: AppColors.textSoft),
    labelLarge: TextStyle(
      fontFamily: 'Nunito',
      fontWeight: FontWeight.w700,
      color: AppColors.textStrong,
    ),
  );
}
