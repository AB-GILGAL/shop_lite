import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

final appTextTheme = const TextTheme(
  displayLarge: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  ),

  headlineLarge: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  ),

  titleLarge: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  ),

  bodyLarge: TextStyle(
    fontSize: 16,
    color: AppColors.textPrimary,
  ),

  bodyMedium: TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  ),
);