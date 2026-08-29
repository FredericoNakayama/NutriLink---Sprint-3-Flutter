import 'package:flutter/material.dart';

/// Paleta de cores do NutriLink, derivada do wireframe (Figma).
///
/// Concentrar as cores aqui evita valores hexadecimais espalhados pelas telas
/// e mantém a identidade visual consistente em todo o app.
class AppColors {
  AppColors._();

  // Marca / azul principal
  static const Color primary = Color(0xFF5BA4D4);
  static const Color primaryDark = Color(0xFF3A7AB8);
  static const Color primaryLight = Color(0xFFD6EAFF);

  // Verde da rede rBLH
  static const Color secondary = Color(0xFF6BAE8E);
  static const Color secondaryDark = Color(0xFF4A8C70);
  static const Color secondaryLight = Color(0xFFF0FAF5);

  // Acentos usados em cards e ícones
  static const Color accentOrange = Color(0xFFE8A87C);
  static const Color accentPurple = Color(0xFF8B7ED4);

  // Superfícies e fundo
  static const Color background = Color(0xFFF4F9FF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceTint = Color(0xFFEDF5FF);
  static const Color border = Color(0xFFD6EAFF);

  // Texto
  static const Color textStrong = Color(0xFF1A2B3C);
  static const Color textMuted = Color(0xFF4A6580);
  static const Color textSoft = Color(0xFF8AAABF);

  // Estados
  static const Color success = Color(0xFF6BAE8E);
  static const Color warning = Color(0xFFE8A87C);
  static const Color danger = Color(0xFFD4183D);
}
