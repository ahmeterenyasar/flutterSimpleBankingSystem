import 'package:flutter/material.dart';
import '../models/wallet.dart';
import '../utils/constants.dart';
import '../utils/formatters.dart';

class WalletCard extends StatelessWidget {
  final Wallet wallet;
  final VoidCallback? onTap;
  final bool isCompact;

  const WalletCard({
    super.key,
    required this.wallet,
    this.onTap,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isCompact) {
      return _buildCompactCard();
    }
    return _buildFullCard();
  }

  Widget _buildFullCard() {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
        vertical: AppDimensions.paddingSmall,
      ),
      elevation: AppDimensions.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: AppDimensions.paddingMedium),
              _buildWalletName(),
              const SizedBox(height: AppDimensions.paddingSmall),
              _buildBalance(),
              const SizedBox(height: AppDimensions.paddingSmall),
              _buildTransactionCount(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompactCard() {
    return Card(
      margin: const EdgeInsets.only(right: AppDimensions.paddingMedium),
      elevation: AppDimensions.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        child: Container(
          width: AppDimensions.walletCardWidth,
          height: AppDimensions.walletCardHeight,
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: _buildCompactWalletName()),
                  _buildWalletIcon(),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCompactBalance(),
                  const SizedBox(height: 4),
                  _buildCategoryBadge(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildCategoryBadge(), _buildWalletIcon()],
    );
  }

  Widget _buildCategoryBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingSmall,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(
          AppDimensions.iconBackgroundOpacity,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
      ),
      child: Text(
        wallet.category.name,
        style: AppTextStyles.caption.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildWalletIcon() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingSmall),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(
          AppDimensions.iconBackgroundOpacity,
        ),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.account_balance_wallet_outlined,
        size: AppDimensions.iconSizeMedium,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildWalletName() {
    return Text(
      wallet.name,
      style: AppTextStyles.subtitle1.copyWith(fontWeight: FontWeight.w600),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildCompactWalletName() {
    return Text(
      wallet.name,
      style: AppTextStyles.caption.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildBalance() {
    return Text(
      AppFormatters.formatCurrency(wallet.balance),
      style: AppTextStyles.heading2.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildCompactBalance() {
    return Text(
      AppFormatters.formatCurrency(wallet.balance),
      style: AppTextStyles.subtitle1.copyWith(fontWeight: FontWeight.bold),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTransactionCount() {
    final count = wallet.transactions.length;
    return Text(
      '$count ${_getTransactionText(count)}',
      style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
    );
  }

  String _getTransactionText(int count) {
    return 'işlem';
  }
}
