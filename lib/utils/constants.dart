import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color.fromARGB(255, 36, 36, 36);
  static const Color primaryDark = Color.fromARGB(255, 34, 34, 34);
  static const Color primaryLight = Color.fromARGB(255, 89, 89, 89);

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
  static const Color error = Color.fromARGB(255, 255, 59, 59);
  static const Color accent = Color.fromARGB(255, 133, 132, 132);

  static const Color accentBlue = Color.fromARGB(255, 123, 163, 211);
  static const Color accentGreen = Color.fromARGB(255, 192, 171, 103);
  static const Color accentOrange = Color.fromARGB(255, 167, 129, 84);

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

  // Splash screen specific
  static const double splashIconContainerSize = 120.0;
  static const double splashIconOpacity = 0.2;
  static const double splashDescriptionOpacity = 0.9;
  static const double splashSubtitleOpacity = 0.7;
  static const double splashTitleFontSize = 36.0;
  static const double buttonHeight = 56.0;

  // Home screen specific
  static const double CardBalanceHeight = 160.0;
  static const double walletCardHeight = 120.0;
  static const double walletCardWidth = 160.0;
  static const double quickActionSize = 64.0;
  static const double transactionItemHeight = 72.0;
  static const double cardElevation = 2.0;
  static const double balanceFontSize = 32.0;

  // Opacity values
  static const double subtitleOpacity = 0.7;
  static const double iconBackgroundOpacity = 0.1;
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

  /// Splash screen texts
  static const String splashDescription = 'Para yönetiminizi kolaylaştırın';
  static const String splashSubtitle =
      'Cüzdanlarınızı yönetin, işlemlerinizi takip edin';
  static const String splashButtonText = 'Başlayalım';

  /// Home screen texts
  static const String totalBalanceLabel = 'Toplam Bakiye';
  static const String walletsLabel = 'Cüzdanlarım';
  static const String recentTransactionsLabel = 'Son İşlemler';
  static const String noWalletsMessage = 'Henüz cüzdan eklemediniz';
  static const String noTransactionsMessage = 'Henüz işlem yapılmadı';
  static const String addWalletButtonText = 'Cüzdan Ekle';

  /// Quick actions
  static const String depositActionText = 'Para Yatır';
  static const String withdrawActionText = 'Para Çek';
  static const String transferActionText = 'Transfer';
  static const String walletsActionText = 'Cüzdanlar';

  /// Wallet Screen
  static const String walletDetailsTitle = 'Cüzdan Detayı';
  static const String currentBalanceLabel = 'Mevcut Bakiye';
  static const String transactionsLabel = 'İşlemler';
  static const String allTransactionsLabel = 'Tüm İşlemler';

  /// Transaction dialog
  static const String depositTitle = 'Para Yatır';
  static const String withdrawTitle = 'Para Çek';
  static const String transferTitle = 'Transfer';
  static const String amountLabel = 'Tutar';
  static const String amountHint = 'Tutar giriniz';
  static const String confirmButtonText = 'Onayla';
  static const String cancelButtonText = 'İptal';
  static const String selectWalletLabel = 'Cüzdan Seçin';
  static const String fromWalletLabel = 'Gönderen Cüzdan';
  static const String toWalletLabel = 'Alıcı Cüzdan';

  /// Wallet
  static const String addWalletTitle = 'Yeni Cüzdan Ekle';
  static const String walletNameLabel = 'Cüzdan Adı';
  static const String walletNameHint = 'Örn: Acil Durum Fonu';
  static const String categoryLabel = 'Kategori';
  static const String selectCategoryLabel = 'Kategori Seçin';
  static const String initialBalanceLabel = 'Başlangıç Bakiyesi';
  static const String initialBalanceHint = '0.00';
  static const String saveButtonText = 'Kaydet';
  static const String createCategoryButtonText = 'Yeni Kategori';

  static const String invalidAmountMessage = 'Geçerli bir tutar giriniz';
  static const String insufficientBalanceMessage = 'Yetersiz bakiye';
  static const String amountMustBePositiveMessage =
      'Tutar sıfırdan büyük olmalıdır';
  static const String selectWalletMessage = 'Lütfen bir cüzdan seçin';
  static const String selectFromWalletMessage = 'Lütfen gönderen cüzdanı seçin';
  static const String selectToWalletMessage = 'Lütfen alıcı cüzdanı seçin';
  static const String sameWalletMessage = 'Aynı cüzdana transfer yapılamaz';
  static const String walletNameRequiredMessage = 'Cüzdan adı gereklidir';
  static const String categoryRequiredMessage = 'Kategori seçimi gereklidir';
  static const String invalidInitialBalanceMessage =
      'Geçerli bir bakiye giriniz';

  static const String depositSuccessMessage = 'Para yatırma işlemi başarılı';
  static const String withdrawSuccessMessage = 'Para çekme işlemi başarılı';
  static const String transferSuccessMessage = 'Transfer işlemi başarılı';
  static const String walletAddedSuccessMessage = 'Cüzdan başarıyla eklendi';

  static const String transactionErrorMessage =
      'İşlem sırasında bir hata oluştu';

  static const String defaultUserName = 'Kullanıcı';
  static const String defaultUserSurname = '';

  static const String dateFormatPattern = 'dd.MM.yyyy';
  static const String timeFormatPattern = 'HH:mm';
  static const String dateTimeFormatPattern = 'dd.MM.yyyy HH:mm';
}
