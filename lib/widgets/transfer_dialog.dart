import 'package:flutter/material.dart';
import '../models/wallet.dart';
import '../models/user.dart';
import '../utils/constants.dart';
import 'common/dialog_wrapper.dart';
import 'common/dialog_actions.dart';
import 'common/form_fields.dart';

class TransferDialog extends StatefulWidget {
  final User user;
  final Wallet? selectedFromWallet;

  const TransferDialog({
    super.key,
    required this.user,
    this.selectedFromWallet,
  });

  @override
  State<TransferDialog> createState() => _TransferDialogState();
}

class _TransferDialogState extends State<TransferDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  Wallet? _fromWallet;
  Wallet? _toWallet;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _fromWallet = widget.selectedFromWallet;
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DialogWrapper(
      title: AppConstants.transferTitle,
      icon: Icons.swap_horiz_rounded,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            WalletDropdownField(
              label: AppConstants.fromWalletLabel,
              wallets: widget.user.wallets,
              value: _fromWallet,
              onChanged: (wallet) {
                setState(() {
                  _fromWallet = wallet;
                  if (_toWallet?.id == wallet?.id) _toWallet = null;
                });
              },
              validator: (value) =>
                  value == null ? AppConstants.selectFromWalletMessage : null,
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            _buildTransferIcon(),
            const SizedBox(height: AppDimensions.paddingMedium),
            WalletDropdownField(
              label: AppConstants.toWalletLabel,
              wallets: widget.user.wallets
                  .where((w) => w.id != _fromWallet?.id)
                  .toList(),
              value: _toWallet,
              onChanged: (wallet) => setState(() => _toWallet = wallet),
              validator: (value) {
                if (value == null) return AppConstants.selectToWalletMessage;
                if (_fromWallet != null && value.id == _fromWallet!.id) {
                  return AppConstants.sameWalletMessage;
                }
                return null;
              },
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            AmountFormField(
              controller: _amountController,
              maxAmount: _fromWallet?.balance,
            ),
            if (_fromWallet != null) ...[
              const SizedBox(height: AppDimensions.paddingMedium),
              BalanceInfoCard(
                label: '${AppConstants.fromWalletLabel} Bakiye',
                balance: _fromWallet!.balance,
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

  Widget _buildTransferIcon() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingSmall),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.arrow_downward_rounded,
          color: AppColors.primary,
          size: AppDimensions.iconSizeMedium,
        ),
      ),
    );
  }

  void _handleConfirm() {
    if (!_formKey.currentState!.validate()) return;

    final amount = double.parse(_amountController.text);
    setState(() => _isProcessing = true);

    try {
      widget.user.transfer(
        fromWallet: _fromWallet!,
        toWallet: _toWallet!,
        amount: amount,
      );

      Navigator.of(context).pop({
        'success': true,
        'fromWallet': _fromWallet,
        'toWallet': _toWallet,
        'amount': amount,
      });
    } catch (e) {
      setState(() => _isProcessing = false);
      showErrorSnackBar(context, e.toString());
    }
  }
}
