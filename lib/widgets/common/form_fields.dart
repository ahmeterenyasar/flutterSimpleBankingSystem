import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/wallet.dart';
import '../../utils/constants.dart';
import '../../utils/formatters.dart';

class AmountFormField extends StatelessWidget {
  final TextEditingController controller;
  final double? maxAmount;
  final bool allowZero;

  const AmountFormField({
    super.key,
    required this.controller,
    this.maxAmount,
    this.allowZero = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppConstants.amountLabel, style: AppTextStyles.subtitle2),
        const SizedBox(height: AppDimensions.paddingSmall),
        TextFormField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          decoration: InputDecoration(
            hintText: AppConstants.amountHint,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingMedium),
              child: Text(
                AppConstants.currencySymbol,
                style: AppTextStyles.subtitle1,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppDimensions.borderRadiusMedium,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppConstants.invalidAmountMessage;
            }
            final amount = double.tryParse(value);
            if (amount == null || (!allowZero && amount <= 0)) {
              return AppConstants.amountMustBePositiveMessage;
            }
            if (maxAmount != null && amount > maxAmount!) {
              return AppConstants.insufficientBalanceMessage;
            }
            return null;
          },
        ),
      ],
    );
  }
}

class WalletDropdownField extends StatelessWidget {
  final String label;
  final List<Wallet> wallets;
  final Wallet? value;
  final ValueChanged<Wallet?> onChanged;
  final String? Function(Wallet?)? validator;

  const WalletDropdownField({
    super.key,
    required this.label,
    required this.wallets,
    required this.value,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.subtitle2),
        const SizedBox(height: AppDimensions.paddingSmall),
        DropdownButtonFormField<Wallet>(
          value: value,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppDimensions.borderRadiusMedium,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMedium,
              vertical: AppDimensions.paddingSmall,
            ),
          ),
          hint: Text(AppConstants.selectWalletLabel),
          items: wallets.map((wallet) {
            return DropdownMenuItem<Wallet>(
              value: wallet,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    size: AppDimensions.iconSizeSmall,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: AppDimensions.paddingSmall),
                  Flexible(
                    child: Text(
                      '${wallet.name} (${AppFormatters.formatCurrency(wallet.balance)})',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }
}

class BalanceInfoCard extends StatelessWidget {
  final String label;
  final double balance;

  const BalanceInfoCard({
    super.key,
    required this.label,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            AppFormatters.formatCurrency(balance),
            style: AppTextStyles.subtitle1.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: AppColors.negative,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
      ),
    ),
  );
}
