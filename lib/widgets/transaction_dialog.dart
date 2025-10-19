import 'package:flutter/material.dart';
import '../models/wallet.dart';
import '../utils/constants.dart';
import 'common/dialog_wrapper.dart';
import 'common/dialog_actions.dart';
import 'common/form_fields.dart';

enum TransactionDialogType { deposit, withdraw }

class TransactionDialog extends StatefulWidget {
  final TransactionDialogType type;
  final List<Wallet> wallets;
  final Wallet? selectedWallet;

  const TransactionDialog({
    super.key,
    required this.type,
    required this.wallets,
    this.selectedWallet,
  });

  @override
  State<TransactionDialog> createState() => _TransactionDialogState();
}

class _TransactionDialogState extends State<TransactionDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  Wallet? _selectedWallet;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _selectedWallet = widget.selectedWallet;
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DialogWrapper(
      title: _getTitle(),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            WalletDropdownField(
              label: AppConstants.selectWalletLabel,
              wallets: widget.wallets,
              value: _selectedWallet,
              onChanged: (wallet) => setState(() => _selectedWallet = wallet),
              validator: (value) =>
                  value == null ? AppConstants.selectWalletMessage : null,
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            AmountFormField(
              controller: _amountController,
              maxAmount: widget.type == TransactionDialogType.withdraw
                  ? _selectedWallet?.balance
                  : null,
            ),
            if (_selectedWallet != null) ...[
              const SizedBox(height: AppDimensions.paddingMedium),
              BalanceInfoCard(
                label: AppConstants.currentBalanceLabel,
                balance: _selectedWallet!.balance,
              ),
            ],
            const SizedBox(height: AppDimensions.paddingLarge),
            DialogActions(
              isProcessing: _isProcessing,
              onConfirm: _handleConfirm,
            ),
          ],
        ),
      ),
    );
  }

  String _getTitle() {
    return widget.type == TransactionDialogType.deposit
        ? AppConstants.depositTitle
        : AppConstants.withdrawTitle;
  }

  void _handleConfirm() {
    if (!_formKey.currentState!.validate()) return;

    final amount = double.parse(_amountController.text);
    setState(() => _isProcessing = true);

    try {
      if (widget.type == TransactionDialogType.deposit) {
        _selectedWallet!.deposit(amount);
      } else {
        _selectedWallet!.withdraw(amount);
      }

      Navigator.of(
        context,
      ).pop({'success': true, 'wallet': _selectedWallet, 'amount': amount});
    } catch (e) {
      setState(() => _isProcessing = false);
      showErrorSnackBar(context, e.toString());
    }
  }
}
