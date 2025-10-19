import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/theme.dart';
import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          _buildImageBanner(context),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingLarge),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBrandingSection(),
                  Column(
                    children: [
                      _buildDescriptionSection(),
                      const SizedBox(height: AppDimensions.paddingXLarge),
                      _buildActionButton(context),
                      const SizedBox(height: AppDimensions.paddingLarge),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageBanner(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final bannerHeight = screenHeight * 2 / 3;

    return Container(
      height: bannerHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Image.asset(
        'assets/images/splash.jpg',
        fit: BoxFit.cover,
        width: double.infinity,
        height: bannerHeight,
      ),
    );
  }

  Widget _buildBrandingSection() {
    return Column(mainAxisSize: MainAxisSize.min, children: [_buildAppTitle()]);
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
            style: AppButtonStyles.light,
            child: Text(AppConstants.splashButtonText),
          ),
        );
      },
    );
  }

  void _navigateToHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }
}
