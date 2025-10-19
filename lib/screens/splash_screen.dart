import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingLarge),
          child: Column(
            children: [
              const Spacer(flex: 2),
              _buildBrandingSection(),
              const Spacer(flex: 3),
              _buildDescriptionSection(),
              const SizedBox(height: AppDimensions.paddingXLarge),
              _buildActionButton(context),
              const SizedBox(height: AppDimensions.paddingLarge),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrandingSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildBrandIcon(),
        const SizedBox(height: AppDimensions.paddingLarge),
        _buildAppTitle(),
      ],
    );
  }

  Widget _buildBrandIcon() {
    return Container(
      width: AppDimensions.splashIconContainerSize,
      height: AppDimensions.splashIconContainerSize,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(AppDimensions.splashIconOpacity),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.account_balance_wallet_rounded,
        size: AppDimensions.iconSizeXLarge,
        color: AppColors.textLight,
      ),
    );
  }

  Widget _buildAppTitle() {
    return Text(
      AppConstants.appName,
      style: AppTextStyles.heading1.copyWith(
        color: AppColors.textLight,
        fontSize: AppDimensions.splashTitleFontSize,
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDescriptionText(),
        const SizedBox(height: AppDimensions.paddingSmall),
        _buildSubtitleText(),
      ],
    );
  }

  Widget _buildDescriptionText() {
    return Text(
      AppConstants.splashDescription,
      style: AppTextStyles.subtitle1.copyWith(
        color: Colors.white.withOpacity(AppDimensions.splashDescriptionOpacity),
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitleText() {
    return Text(
      AppConstants.splashSubtitle,
      style: AppTextStyles.body2.copyWith(
        color: Colors.white.withOpacity(AppDimensions.splashSubtitleOpacity),
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: AppDimensions.buttonHeight,
          child: ElevatedButton(
            onPressed: () => _navigateToHome(context),
            style: _buildButtonStyle(),
            child: _buildButtonText(),
          ),
        );
      },
    );
  }

  ButtonStyle _buildButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.textLight,
      foregroundColor: AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      elevation: 0,
    );
  }

  Widget _buildButtonText() {
    return Text(
      AppConstants.splashButtonText,
      style: AppTextStyles.button.copyWith(color: AppColors.primary),
    );
  }

  void _navigateToHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }
}
