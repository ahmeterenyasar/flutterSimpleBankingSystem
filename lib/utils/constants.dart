import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF444444);
  static const Color primaryDark = Color(0xFF222222);
  static const Color primaryLight = Color(0xFF666666);

  static const Color background = Color(0xFFF5F5F5);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardBackgroundDark = Color(0xFF1E1E1E);

  static const Color textPrimary = Color(0xFF1C1C1C);
  static const Color textSecondary = Color(0xFF555555);
  static const Color textLight = Color(0xFFFFFFFF);
  static const Color textDisabled = Color(0xFFAAAAAA);

  static const Color positive = Color.fromARGB(255, 43, 125, 18);
  static const Color negative = Color.fromARGB(255, 222, 65, 65);
  static const Color warning = Color.fromARGB(255, 202, 210, 43);
  static const Color error = Color(0xFF555555);
  static const Color accent = Color(0xFF777777);

  static const Color accentBlue = Color(0xFF999999);
  static const Color accentGreen = Color(0xFFBBBBBB);
  static const Color accentOrange = Color(0xFF888888);

  static const Color divider = Color(0xFFE0E0E0);
  static const Color shadow = Color(0x33000000);
}

class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );
  
  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
  );
  
  static const TextStyle heading3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle subtitle1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle subtitle2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );
  
  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
  
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
  
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.5,
  );
}

class AppDimensions {
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;
  
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 12.0;
  static const double borderRadiusLarge = 16.0;
  static const double borderRadiusXLarge = 24.0;
  
  static const double iconSizeSmall = 20.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;
  static const double iconSizeXLarge = 60.0;
  
  static const double avatarSizeSmall = 40.0;
  static const double avatarSizeMedium = 56.0;
  static const double avatarSizeLarge = 80.0;
  
  static const double splashIconContainerSize = 120.0;
  static const double splashIconOpacity = 0.2;
  static const double splashDescriptionOpacity = 0.9;
  static const double splashSubtitleOpacity = 0.7;
  static const double splashTitleFontSize = 36.0;
  static const double buttonHeight = 56.0;
}

class AppConstants {
  static const String appName = 'Simple Banking';
  static const String currency = 'TRY';
  static const String currencySymbol = '₺';
  
  static const String userDataKey = 'user_data';
  static const String themeKey = 'theme_mode';
  
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Splash screen texts
  static const String splashDescription = 'Para yönetimi app test';
  static const String splashSubtitle = 'Cüzdan yönet, işlem takip et';
  static const String splashButtonText = 'Başla';
}

