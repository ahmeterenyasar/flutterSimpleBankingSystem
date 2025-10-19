import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/formatters.dart';

class CardBalance extends StatelessWidget {
  final double totalBalance;
  final int walletCount;
  final VoidCallback? onTap;

  const CardBalance({
    super.key,
    required this.totalBalance,
    required this.walletCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(AppDimensions.paddingMedium),
      elevation: AppDimensions.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
        child: Container(
          height: AppDimensions.CardBalanceHeight,
          padding: const EdgeInsets.all(AppDimensions.paddingLarge),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, AppColors.primaryDark],
            ),
            borderRadius: BorderRadius.circular(
              AppDimensions.borderRadiusLarge,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_buildHeader(), _buildBalanceSection(), _buildFooter()],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppConstants.totalBalanceLabel,
          style: AppTextStyles.subtitle1.copyWith(
            color: AppColors.textLight.withOpacity(
              AppDimensions.subtitleOpacity,
            ),
          ),
        ),
        Icon(
          Icons.account_balance_wallet_outlined,
          color: AppColors.textLight.withOpacity(AppDimensions.subtitleOpacity),
          size: AppDimensions.iconSizeMedium,
        ),
      ],
    );
  }

  Widget _buildBalanceSection() {
    return Text(
      AppFormatters.formatCurrency(totalBalance),
      style: AppTextStyles.heading1.copyWith(
        color: AppColors.textLight,
        fontSize: AppDimensions.balanceFontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      children: [
        Icon(
          Icons.wallet,
          size: AppDimensions.iconSizeSmall,
          color: AppColors.textLight.withOpacity(AppDimensions.subtitleOpacity),
        ),
        const SizedBox(width: AppDimensions.paddingSmall),
        Text(
          '$walletCount ${_getWalletText()}',
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textLight.withOpacity(
              AppDimensions.subtitleOpacity,
            ),
          ),
        ),
      ],
    );
  }

  String _getWalletText() {
    if (walletCount == 0) return 'cüzdan';
    if (walletCount == 1) return 'cüzdan';
    return 'cüzdan';
  }
}
