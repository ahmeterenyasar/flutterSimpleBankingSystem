import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../utils/constants.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final String? emptyMessage;
  final int? maxItems;

  const TransactionList({
    super.key,
    required this.transactions,
    this.emptyMessage,
    this.maxItems,
  });

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return _buildEmptyState();
    }

    final displayTransactions =
        maxItems != null && maxItems! < transactions.length
        ? transactions.take(maxItems!).toList()
        : transactions;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_buildHeader(), _buildTransactionItems(displayTransactions)],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: Text(
        AppConstants.recentTransactionsLabel,
        style: AppTextStyles.heading3,
      ),
    );
  }

  Widget _buildTransactionItems(List<Transaction> items) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (context, index) => const Divider(
        height: 1,
        indent:
            AppDimensions.paddingMedium +
            AppDimensions.avatarSizeSmall +
            AppDimensions.paddingMedium,
        endIndent: AppDimensions.paddingMedium,
      ),
      itemBuilder: (context, index) {
        return TransactionItem(
          transaction: items[index],
          onTap: () => _handleTransactionTap(items[index]),
        );
      },
    );
  }

  Widget _buildEmptyState() {
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
              emptyMessage ?? AppConstants.noTransactionsMessage,
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

  void _handleTransactionTap(Transaction transaction) {}
}
