import 'package:flutter/material.dart';
import '../models/wallet.dart';
import '../models/transaction.dart';
import '../utils/constants.dart';
import '../utils/formatters.dart';
import '../widgets/transaction_item.dart';
import '../widgets/transaction_dialog.dart';

class WalletDetailsScreen extends StatefulWidget {
  final Wallet wallet;
  final VoidCallback onUpdate;

  const WalletDetailsScreen({
    super.key,
    required this.wallet,
    required this.onUpdate,
  });

  @override
  State<WalletDetailsScreen> createState() => _WalletDetailsScreenState();
}

class _WalletDetailsScreenState extends State<WalletDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomActions(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.cardBackground,
      elevation: 0,
      title: Text(widget.wallet.name, style: AppTextStyles.heading3),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardBalance(),
          const SizedBox(height: AppDimensions.paddingMedium),
          _buildTransactionsList(),
        ],
      ),
    );
  }

  Widget _buildCardBalance() {
    return Container(
      margin: const EdgeInsets.all(AppDimensions.paddingMedium),
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBalanceHeader(),
          const SizedBox(height: AppDimensions.paddingLarge),
          _buildBalanceAmount(),
          const SizedBox(height: AppDimensions.paddingSmall),
          _buildTransactionCount(),
        ],
      ),
    );
  }

  Widget _buildBalanceHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium,
            vertical: AppDimensions.paddingSmall,
          ),
          decoration: BoxDecoration(
            color: AppColors.textLight.withOpacity(0.2),
            borderRadius: BorderRadius.circular(
              AppDimensions.borderRadiusSmall,
            ),
          ),
          child: Text(
            widget.wallet.category.name,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textLight,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Icon(
          Icons.account_balance_wallet_outlined,
          color: AppColors.textLight.withOpacity(AppDimensions.subtitleOpacity),
          size: AppDimensions.iconSizeLarge,
        ),
      ],
    );
  }

  Widget _buildBalanceAmount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppConstants.currentBalanceLabel,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textLight.withOpacity(
              AppDimensions.subtitleOpacity,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          AppFormatters.formatCurrency(widget.wallet.balance),
          style: AppTextStyles.heading1.copyWith(
            color: AppColors.textLight,
            fontSize: AppDimensions.balanceFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionCount() {
    final count = widget.wallet.transactions.length;
    return Row(
      children: [
        Icon(
          Icons.receipt_long_outlined,
          size: AppDimensions.iconSizeSmall,
          color: AppColors.textLight.withOpacity(AppDimensions.subtitleOpacity),
        ),
        const SizedBox(width: AppDimensions.paddingSmall),
        Text(
          '$count işlem',
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textLight.withOpacity(
              AppDimensions.subtitleOpacity,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionsList() {
    if (widget.wallet.transactions.isEmpty) {
      return _buildEmptyTransactions();
    }

    // Sort transactions by date (most recent first)
    final sortedTransactions = List<Transaction>.from(
      widget.wallet.transactions,
    )..sort((a, b) => b.date.compareTo(a.date));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium,
          ),
          child: Text(
            AppConstants.transactionsLabel,
            style: AppTextStyles.heading3,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingSmall),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sortedTransactions.length,
          separatorBuilder: (context, index) => const Divider(
            height: 1,
            indent:
                AppDimensions.paddingMedium +
                AppDimensions.avatarSizeSmall +
                AppDimensions.paddingMedium,
            endIndent: AppDimensions.paddingMedium,
          ),
          itemBuilder: (context, index) {
            return TransactionItem(transaction: sortedTransactions[index]);
          },
        ),
        const SizedBox(height: AppDimensions.paddingXLarge),
      ],
    );
  }

  Widget _buildEmptyTransactions() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingXLarge),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: AppDimensions.iconSizeXLarge,
              color: AppColors.textDisabled,
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            Text(
              AppConstants.noTransactionsMessage,
              style: AppTextStyles.body2.copyWith(
                color: AppColors.textDisabled,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: _buildActionButton(
                label: AppConstants.depositActionText,
                icon: Icons.add_rounded,
                color: AppColors.positive,
                onTap: _handleDeposit,
              ),
            ),
            const SizedBox(width: AppDimensions.paddingMedium),
            Expanded(
              child: _buildActionButton(
                label: AppConstants.withdrawActionText,
                icon: Icons.remove_rounded,
                color: AppColors.negative,
                onTap: _handleWithdraw,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: AppColors.textLight,
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.paddingMedium,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        ),
      ),
    );
  }

  Future<void> _handleDeposit() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => TransactionDialog(
        type: TransactionDialogType.deposit,
        wallets: [widget.wallet],
        selectedWallet: widget.wallet,
      ),
    );

    if (result != null && result['success'] == true) {
      setState(() {});
      widget.onUpdate();
      _showSuccessMessage(AppConstants.depositSuccessMessage);
    }
  }

  Future<void> _handleWithdraw() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => TransactionDialog(
        type: TransactionDialogType.withdraw,
        wallets: [widget.wallet],
        selectedWallet: widget.wallet,
      ),
    );

    if (result != null && result['success'] == true) {
      setState(() {});
      widget.onUpdate();
      _showSuccessMessage(AppConstants.withdrawSuccessMessage);
    }
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.positive,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
        ),
      ),
    );
  }
}
