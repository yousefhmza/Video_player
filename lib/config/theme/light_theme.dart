import 'package:flutter/material.dart';

import '../../core/resources/resources.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColors.white,

    colorScheme: const ColorScheme.light().copyWith(primary: AppColors.primary, surfaceTint: AppColors.white),

    /// Bottom sheet
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: AppColors.white),

    /// Appbar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      elevation: AppSize.s0,
      scrolledUnderElevation: AppSize.s0,
    ),

    /// Progress indicator theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: AppColors.primary),

    /// Icon theme
    iconTheme: const IconThemeData(color: AppColors.black),

    /// Icon theme
    dividerColor: AppColors.grey500.withOpacity(0.2),
    dividerTheme: DividerThemeData(color: AppColors.grey500.withOpacity(0.2)),
  );
}
