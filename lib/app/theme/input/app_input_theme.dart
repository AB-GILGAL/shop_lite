import 'package:flutter/material.dart';

import '../colors/app_colors.dart';
import '../radius/app_radius.dart';

abstract final class AppInputTheme {
  const AppInputTheme._();

  static final InputDecorationTheme light =
      InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,

    border: OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(AppRadius.md),
      borderSide: const BorderSide(
        color: AppColors.border,
      ),
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(AppRadius.md),
      borderSide: const BorderSide(
        color: AppColors.border,
      ),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(AppRadius.md),
      borderSide: const BorderSide(
        color: AppColors.primary,
        width: 2,
      ),
    ),

    errorBorder: OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(AppRadius.md),
      borderSide: const BorderSide(
        color: AppColors.error,
      ),
    ),
  );
}