import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../utils/constants.dart';
import '../utils/formatters.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback? onTap;

  const TransactionItem({super.key, required this.transaction, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: AppDimensions.transactionItemHeight,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium,
          vertical: AppDimensions.paddingSmall,
        ),
        child: Row(
          children: [
            _buildIcon(),
            const SizedBox(width: AppDimensions.paddingMedium),
            Expanded(child: _buildTransactionInfo()),
            _buildAmount(),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: AppDimensions.avatarSizeSmall,
      height: AppDimensions.avatarSizeSmall,
      decoration: BoxDecoration(
        color: _getIconBackgroundColor(),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
      ),
      child: Icon(
        _getTransactionIcon(),
        color: _getIconColor(),
        size: AppDimensions.iconSizeMedium,
      ),
    );
  }

  Widget _buildTransactionInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _getTransactionTitle(),
          style: AppTextStyles.subtitle1,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          AppFormatters.formatRelativeTime(transaction.date),
          style: AppTextStyles.caption,
        ),
      ],
    );
  }

  Widget _buildAmount() {
    return Text(
      _getFormattedAmount(),
      style: AppTextStyles.subtitle1.copyWith(
        color: _getAmountColor(),
        fontWeight: FontWeight.w600,
      ),
    );
  }

  IconData _getTransactionIcon() {
    switch (transaction.type) {
      case TransactionType.deposit:
        return Icons.arrow_downward_rounded;
      case TransactionType.withdraw:
        return Icons.arrow_upward_rounded;
      case TransactionType.transfer:
        return Icons.swap_horiz_rounded;
    }
  }

  Color _getIconColor() {
    switch (transaction.type) {
      case TransactionType.deposit:
        return AppColors.positive;
      case TransactionType.withdraw:
        return AppColors.negative;
      case TransactionType.transfer:
        return AppColors.primary;
    }
  }

  Color _getIconBackgroundColor() {
    return _getIconColor().withOpacity(AppDimensions.iconBackgroundOpacity);
  }

  Color _getAmountColor() {
    switch (transaction.type) {
      case TransactionType.deposit:
        return AppColors.positive;
      case TransactionType.withdraw:
        return AppColors.negative;
      case TransactionType.transfer:
        return AppColors.textSecondary;
    }
  }

  String _getFormattedAmount() {
    final prefix = transaction.type == TransactionType.deposit ? '+' : '-';
    return '$prefix${AppFormatters.formatCurrency(transaction.amount)}';
  }

  String _getTransactionTitle() {
    switch (transaction.type) {
      case TransactionType.deposit:
        return 'Para Yatırma';
      case TransactionType.withdraw:
        return 'Para Çekme';
      case TransactionType.transfer:
        return 'Transfer';
    }
  }
}
