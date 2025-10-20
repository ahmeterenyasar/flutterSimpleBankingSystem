import 'package:flutter/material.dart';
import '../models/wallet.dart';
import '../utils/constants.dart';
import '../utils/formatters.dart';

class WalletCard extends StatelessWidget {
  final Wallet wallet;
  final VoidCallback? onTap;

  const WalletCard({
    super.key,
    required this.wallet,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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

  Widget _buildBalance() {
    return Text(
      AppFormatters.formatCurrency(wallet.balance),
      style: AppTextStyles.heading2.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildTransactionCount() {
    final count = wallet.transactions.length;
    return Text(
      '$count işlem',
      style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
    );
  }
}
