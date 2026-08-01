import 'package:flutter/material.dart';

/// Centralized color palette for the application.
///
/// Never use Colors.blue, Colors.red, etc.
/// Always reference AppColors.
abstract final class AppColors {
  AppColors._();

  // Brand
  static const primary = Color(0xFF1565C0);
  static const secondary = Color(0xFFFF9800);

  // Surfaces
  static const background = Color(0xFFF8F9FA);
  static const surface = Colors.white;

  // Text
  static const textPrimary = Color(0xFF1C1C1E);
  static const textSecondary = Color(0xFF6E6E73);

  // Border
  static const border = Color(0xFFE5E5EA);

  // Status
  static const success = Color(0xFF2E7D32);
  static const warning = Color(0xFFFFB300);
  static const error = Color(0xFFD32F2F);

  // Misc
  static const transparent = Colors.transparent;
}