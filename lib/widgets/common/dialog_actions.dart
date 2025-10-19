import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class DialogActions extends StatelessWidget {
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;
  final String? confirmText;
  final String? cancelText;
  final bool isProcessing;

  const DialogActions({
    super.key,
    this.onCancel,
    this.onConfirm,
    this.confirmText,
    this.cancelText,
    this.isProcessing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: isProcessing
                ? null
                : (onCancel ?? () => Navigator.of(context).pop()),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.paddingMedium,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppDimensions.borderRadiusMedium,
                ),
              ),
            ),
            child: Text(cancelText ?? AppConstants.cancelButtonText),
          ),
        ),
        const SizedBox(width: AppDimensions.paddingMedium),
        Expanded(
          child: ElevatedButton(
            onPressed: isProcessing ? null : onConfirm,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.paddingMedium,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppDimensions.borderRadiusMedium,
                ),
              ),
            ),
            child: isProcessing
                ? const SizedBox(
                    width: AppDimensions.iconSizeSmall,
                    height: AppDimensions.iconSizeSmall,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.textLight,
                    ),
                  )
                : Text(confirmText ?? AppConstants.confirmButtonText),
          ),
        ),
      ],
    );
  }
}
