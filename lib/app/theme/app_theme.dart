import 'package:flutter/material.dart';
import 'package:shop_lite/app/theme/buttons/app_button_theme.dart';
import 'package:shop_lite/app/theme/input/app_input_theme.dart';

import 'colors/app_colors.dart';
import 'typography/app_text_theme.dart';

final appTheme = ThemeData(
  useMaterial3: true,

  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
  ),

  scaffoldBackgroundColor: AppColors.background,

   textTheme: appTextTheme,

  inputDecorationTheme:
      AppInputTheme.light,

  filledButtonTheme:
      AppButtonTheme.filledButtonTheme,

  outlinedButtonTheme:
      AppButtonTheme.outlinedButtonTheme,

  textButtonTheme:
      AppButtonTheme.textButtonTheme,

  appBarTheme: const AppBarTheme(
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.transparent,
  ),
);