import 'package:intl/intl.dart';
import 'constants.dart';

class AppFormatters {
  // Private constructor to prevent instantiation
  AppFormatters._();

  /// Formats a double amount to currency string with symbol
  static String formatCurrency(double amount) {
    final formatter = NumberFormat('#,##0.00', 'tr_TR');
    return '${formatter.format(amount)} ${AppConstants.currencySymbol}';
  }

  /// Formats a double amount to compact currency string (e.g., 1.5K, 2.3M)
  static String formatCompactCurrency(double amount) {
    final formatter = NumberFormat.compact(locale: 'tr_TR');
    return '${formatter.format(amount)} ${AppConstants.currencySymbol}';
  }

  static String formatDate(DateTime date) {
    final formatter = DateFormat(AppConstants.dateFormatPattern, 'tr_TR');
    return formatter.format(date);
  }

  static String formatTime(DateTime date) {
    final formatter = DateFormat(AppConstants.timeFormatPattern, 'tr_TR');
    return formatter.format(date);
  }

  /// Formats DateTime to full date-time string
  static String formatDateTime(DateTime date) {
    final formatter = DateFormat(AppConstants.dateTimeFormatPattern, 'tr_TR');
    return formatter.format(date);
  }

  /// Formats DateTime to relative time (e.g., "Bugün", "Dün", "2 gün önce")
  static String formatRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Bugün ${formatTime(date)}';
    } else if (difference.inDays == 1) {
      return 'Dün ${formatTime(date)}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} gün önce';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks hafta önce';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months ay önce';
    } else {
      return formatDate(date);
    }
  }

  /// Formats a number with thousand separators
  static String formatNumber(double number) {
    final formatter = NumberFormat('#,##0', 'tr_TR');
    return formatter.format(number);
  }

  /// Formats percentage
  static String formatPercentage(double value, {int decimals = 1}) {
    return '${value.toStringAsFixed(decimals)}%';
  }
}
