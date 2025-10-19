import 'package:flutter/material.dart';
import '../utils/constants.dart';

class QuickAction {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color? backgroundColor;

  const QuickAction({
    required this.label,
    required this.icon,
    required this.onTap,
    this.backgroundColor,
  });
}

class QuickActionsSection extends StatelessWidget {
  final List<QuickAction> actions;

  const QuickActionsSection({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
        vertical: AppDimensions.paddingSmall,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: actions
            .map((action) => _buildQuickActionItem(action))
            .toList(),
      ),
    );
  }

  Widget _buildQuickActionItem(QuickAction action) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingSmall,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildActionButton(action),
            const SizedBox(height: AppDimensions.paddingSmall),
            _buildActionLabel(action),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(QuickAction action) {
    return Material(
      color: action.backgroundColor ?? AppColors.primary,
      borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      child: InkWell(
        onTap: action.onTap,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        child: Container(
          width: AppDimensions.quickActionSize,
          height: AppDimensions.quickActionSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppDimensions.borderRadiusMedium,
            ),
          ),
          child: Icon(
            action.icon,
            color: AppColors.textLight,
            size: AppDimensions.iconSizeLarge,
          ),
        ),
      ),
    );
  }

  Widget _buildActionLabel(QuickAction action) {
    return Text(
      action.label,
      style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
