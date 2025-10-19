import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class DialogWrapper extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Widget child;
  final VoidCallback? onClose;

  const DialogWrapper({
    super.key,
    required this.title,
    required this.child,
    this.icon,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingLarge),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context),
              const SizedBox(height: AppDimensions.paddingLarge),
              child,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: AppColors.primary,
                size: AppDimensions.iconSizeLarge,
              ),
              const SizedBox(width: AppDimensions.paddingSmall),
            ],
            Text(title, style: AppTextStyles.heading3),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            if (onClose != null) {
              onClose!();
            } else {
              Navigator.of(context).pop();
            }
          },
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }
}
