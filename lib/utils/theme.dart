import 'package:flutter/material.dart';
import 'constants.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      // Color Scheme
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.primaryLight,
        surface: AppColors.cardBackground,
        background: AppColors.background,
      ),

      // Scaffold
      scaffoldBackgroundColor: AppColors.background,

      // App Bar
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Card
      cardTheme: CardThemeData(
        elevation: AppDimensions.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
        ),
        color: AppColors.cardBackground,
      ),

      // Elevated Button (Default)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textLight,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingLarge,
            vertical: AppDimensions.paddingMedium,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.borderRadiusMedium,
            ),
          ),
          textStyle: AppTextStyles.button,
        ),
      ),

      // Outlined Button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingLarge,
            vertical: AppDimensions.paddingMedium,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.borderRadiusMedium,
            ),
          ),
          side: const BorderSide(color: AppColors.primary),
          textStyle: AppTextStyles.button,
        ),
      ),

      // Text Button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium,
            vertical: AppDimensions.paddingSmall,
          ),
          textStyle: AppTextStyles.button,
        ),
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.cardBackground,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium,
          vertical: AppDimensions.paddingSmall,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.negative),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.negative, width: 2),
        ),
        labelStyle: AppTextStyles.body2.copyWith(
          color: AppColors.textSecondary,
        ),
        hintStyle: AppTextStyles.body2.copyWith(color: AppColors.textDisabled),
        errorStyle: AppTextStyles.caption.copyWith(color: AppColors.negative),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),

      // Dialog
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.cardBackground,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
        ),
      ),

      // Bottom Sheet
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.cardBackground,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppDimensions.borderRadiusLarge),
            topRight: Radius.circular(AppDimensions.borderRadiusLarge),
          ),
        ),
      ),

      // Snack Bar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textPrimary,
        contentTextStyle: AppTextStyles.body2.copyWith(
          color: AppColors.textLight,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
        ),
      ),
    );
  }
}

// Custom Button Styles for specific use cases
class AppButtonStyles {
  // Success/Positive Button (e.g., Deposit)
  static ButtonStyle get positive {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.positive,
      foregroundColor: AppColors.textLight,
      elevation: 0,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLarge,
        vertical: AppDimensions.paddingMedium,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      textStyle: AppTextStyles.button,
    );
  }

  // Error/Negative Button (e.g., Withdraw)
  static ButtonStyle get negative {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.negative,
      foregroundColor: AppColors.textLight,
      elevation: 0,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLarge,
        vertical: AppDimensions.paddingMedium,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      textStyle: AppTextStyles.button,
    );
  }

  // Light/Inverse Button (e.g., Splash Screen)
  static ButtonStyle get light {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.textLight,
      foregroundColor: AppColors.primary,
      elevation: 0,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLarge,
        vertical: AppDimensions.paddingMedium,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      textStyle: AppTextStyles.button,
    );
  }

  // Small Button
  static ButtonStyle get small {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textLight,
      elevation: 0,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
        vertical: AppDimensions.paddingSmall,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
      ),
      textStyle: AppTextStyles.caption,
    );
  }
}
