import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/wallet.dart';
import '../utils/constants.dart';
import '../widgets/wallet_card.dart';
import 'wallet_details_screen.dart';

class WalletsListScreen extends StatefulWidget {
  final User user;
  final VoidCallback onUpdate;

  const WalletsListScreen({
    super.key,
    required this.user,
    required this.onUpdate,
  });

  @override
  State<WalletsListScreen> createState() => _WalletsListScreenState();
}

class _WalletsListScreenState extends State<WalletsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.cardBackground,
      elevation: 0,
      title: Text(AppConstants.walletsLabel, style: AppTextStyles.heading3),
    );
  }

  Widget _buildBody() {
    if (widget.user.wallets.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.paddingMedium,
      ),
      itemCount: widget.user.wallets.length,
      itemBuilder: (context, index) {
        final wallet = widget.user.wallets[index];
        return WalletCard(
          wallet: wallet,
          onTap: () => _handleWalletTap(context, wallet),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingXLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_balance_wallet_outlined,
              size: AppDimensions.iconSizeXLarge * 1.5,
              color: AppColors.textDisabled,
            ),
            const SizedBox(height: AppDimensions.paddingLarge),
            Text(
              AppConstants.noWalletsMessage,
              style: AppTextStyles.subtitle1.copyWith(
                color: AppColors.textDisabled,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _handleWalletTap(BuildContext context, Wallet wallet) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            WalletDetailsScreen(wallet: wallet, onUpdate: widget.onUpdate),
      ),
    );

    setState(() {});
  }
}
