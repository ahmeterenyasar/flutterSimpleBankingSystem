import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/wallet.dart';
import '../models/category.dart';
import '../models/user.dart';
import '../utils/constants.dart';
import 'common/dialog_wrapper.dart';
import 'common/dialog_actions.dart';

class AddWalletDialog extends StatefulWidget {
  final User user;

  const AddWalletDialog({super.key, required this.user});

  @override
  State<AddWalletDialog> createState() => _AddWalletDialogState();
}

class _AddWalletDialogState extends State<AddWalletDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _balanceController = TextEditingController(text: '0.00');
  Category? _selectedCategory;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    if (widget.user.categories.isNotEmpty) {
      _selectedCategory = widget.user.categories.first;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _balanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DialogWrapper(
      title: AppConstants.addWalletTitle,
      icon: Icons.add_circle_outline,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildNameField(),
            const SizedBox(height: AppDimensions.paddingMedium),
            _buildCategoryDropdown(),
            const SizedBox(height: AppDimensions.paddingMedium),
            _buildBalanceField(),
            const SizedBox(height: AppDimensions.paddingLarge),
            DialogActions(isProcessing: _isProcessing, onConfirm: _handleSave),
          ],
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppConstants.walletNameLabel, style: AppTextStyles.subtitle2),
        const SizedBox(height: AppDimensions.paddingSmall),
        TextFormField(
          controller: _nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            hintText: AppConstants.walletNameHint,
            prefixIcon: Icon(Icons.account_balance_wallet_outlined),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return AppConstants.walletNameRequiredMessage;
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppConstants.categoryLabel, style: AppTextStyles.subtitle2),
        const SizedBox(height: AppDimensions.paddingSmall),
        DropdownButtonFormField<Category>(
          initialValue: _selectedCategory,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMedium,
              vertical: AppDimensions.paddingSmall,
            ),
            prefixIcon: Icon(Icons.category_outlined),
          ),
          hint: Text(AppConstants.selectCategoryLabel),
          items: widget.user.categories.map((category) {
            return DropdownMenuItem<Category>(
              value: category,
              child: Text(category.name, overflow: TextOverflow.ellipsis),
            );
          }).toList(),
          onChanged: (category) {
            setState(() => _selectedCategory = category);
          },
          validator: (value) {
            if (value == null) {
              return AppConstants.categoryRequiredMessage;
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildBalanceField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppConstants.initialBalanceLabel, style: AppTextStyles.subtitle2),
        const SizedBox(height: AppDimensions.paddingSmall),
        TextFormField(
          controller: _balanceController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          decoration: InputDecoration(
            hintText: AppConstants.initialBalanceHint,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingMedium),
              child: Text(
                AppConstants.currencySymbol,
                style: AppTextStyles.subtitle1,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppConstants.invalidInitialBalanceMessage;
            }
            final balance = double.tryParse(value);
            if (balance == null || balance < 0) {
              return AppConstants.invalidInitialBalanceMessage;
            }
            return null;
          },
        ),
        const SizedBox(height: AppDimensions.paddingSmall),
        Text(
          'Not: Başlangıç bakiyesi 0 veya daha fazla olabilir',
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondary,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  void _handleSave() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isProcessing = true);

    try {
      final newWallet = Wallet(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        balance: double.parse(_balanceController.text),
        category: _selectedCategory!,
      );

      widget.user.addWallet(newWallet);

      Navigator.of(context).pop({'success': true, 'wallet': newWallet});
    } catch (e) {
      setState(() => _isProcessing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: AppColors.negative,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
