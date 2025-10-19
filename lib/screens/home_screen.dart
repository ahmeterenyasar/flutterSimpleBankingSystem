import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/category.dart';
import '../models/wallet.dart';
import '../models/transaction.dart';
import '../services/storage_service.dart';
import '../utils/constants.dart';
import '../widgets/card_balance.dart';
import '../widgets/quick_actions.dart';
import '../widgets/transaction_list.dart';
import '../widgets/transaction_dialog.dart';
import '../widgets/transfer_dialog.dart';
import '../widgets/add_wallet_dialog.dart';
import 'wallets_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User currentUser;
  late StorageService storageService;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    storageService = await StorageService.getInstance();
    await _loadOrCreateUser();
    setState(() => isLoading = false);
  }

  Future<void> _loadOrCreateUser() async {
    final user = await storageService.loadUser();
    if (user != null) {
      currentUser = user;
    } else {
      currentUser = _createDefaultUser();
      await storageService.saveUser(currentUser);
    }
  }

  User _createDefaultUser() {
    // Create default categories
    final personalCategory = Category(id: '1', name: 'Kişisel');
    final businessCategory = Category(id: '2', name: 'İş');

    // Create a default wallet
    final defaultWallet = Wallet(
      id: '1',
      name: 'Ana Cüzdan',
      balance: 0.0,
      category: personalCategory,
    );

    return User(
      name: AppConstants.defaultUserName,
      surname: AppConstants.defaultUserSurname,
      wallets: [defaultWallet],
      categories: [personalCategory, businessCategory],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildLoadingScreen();
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.cardBackground,
      elevation: 0,
      title: _buildAppBarTitle(),
      actions: [_buildNotificationButton(), _buildProfileButton()],
    );
  }

  Widget _buildAppBarTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Merhaba,',
          style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
        ),
        Text(
          currentUser.getFullName(),
          style: AppTextStyles.subtitle1.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildNotificationButton() {
    return IconButton(
      icon: const Icon(Icons.notifications_outlined),
      onPressed: _handleNotificationTap,
      color: AppColors.textPrimary,
    );
  }

  Widget _buildProfileButton() {
    return Padding(
      padding: const EdgeInsets.only(right: AppDimensions.paddingSmall),
      child: IconButton(
        icon: CircleAvatar(
          backgroundColor: AppColors.primary,
          child: Text(
            _getUserInitials(),
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textLight,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onPressed: _handleProfileTap,
      ),
    );
  }

  Widget _buildBody() {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBalanceCard(),
            const SizedBox(height: AppDimensions.paddingSmall),
            _buildQuickActions(),
            const SizedBox(height: AppDimensions.paddingMedium),
            _buildTransactionSection(),
            const SizedBox(height: AppDimensions.paddingXLarge),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return BalanceCard(
      totalBalance: currentUser.getTotalBalance(),
      walletCount: currentUser.getWalletCount(),
      onTap: _handleBalanceCardTap,
    );
  }

  Widget _buildQuickActions() {
    return QuickActionsSection(
      actions: [
        QuickAction(
          label: AppConstants.depositActionText,
          icon: Icons.add_rounded,
          onTap: _handleDepositTap,
          backgroundColor: AppColors.positive,
        ),
        QuickAction(
          label: AppConstants.withdrawActionText,
          icon: Icons.remove_rounded,
          onTap: _handleWithdrawTap,
          backgroundColor: AppColors.negative,
        ),
        QuickAction(
          label: AppConstants.transferActionText,
          icon: Icons.swap_horiz_rounded,
          onTap: _handleTransferTap,
          backgroundColor: AppColors.primary,
        ),
        QuickAction(
          label: AppConstants.walletsActionText,
          icon: Icons.account_balance_wallet_rounded,
          onTap: _handleWalletsTap,
          backgroundColor: AppColors.accentBlue,
        ),
      ],
    );
  }

  Widget _buildTransactionSection() {
    final allTransactions = _getAllTransactions();
    return TransactionList(transactions: allTransactions, maxItems: 10);
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: _handleAddWallet,
      backgroundColor: AppColors.primary,
      icon: const Icon(Icons.add, color: AppColors.textLight),
      label: Text(
        AppConstants.addWalletButtonText,
        style: AppTextStyles.button.copyWith(fontSize: 14),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
    );
  }

  // Helper methods
  String _getUserInitials() {
    final firstName = currentUser.name.isNotEmpty ? currentUser.name[0] : '';
    final lastName = currentUser.surname.isNotEmpty
        ? currentUser.surname[0]
        : '';
    return (firstName + lastName).toUpperCase();
  }

  List<Transaction> _getAllTransactions() {
    final allTransactions = <Transaction>[];
    for (var wallet in currentUser.wallets) {
      allTransactions.addAll(wallet.transactions);
    }
    // Sort by date, most recent first
    allTransactions.sort((a, b) => b.date.compareTo(a.date));
    return allTransactions;
  }

  // Action handlers
  Future<void> _handleRefresh() async {
    await _loadOrCreateUser();
    setState(() {});
  }

  void _handleNotificationTap() {
    // TODO: Navigate to notifications screen
    _showComingSoonSnackBar('Bildirimler');
  }

  void _handleProfileTap() {
    // TODO: Navigate to profile screen
    _showComingSoonSnackBar('Profil');
  }

  void _handleBalanceCardTap() {
    _handleWalletsTap();
  }

  Future<void> _handleDepositTap() async {
    if (currentUser.wallets.isEmpty) {
      _showErrorMessage(AppConstants.noWalletsMessage);
      return;
    }

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => TransactionDialog(
        type: TransactionDialogType.deposit,
        wallets: currentUser.wallets,
      ),
    );

    if (result != null && result['success'] == true) {
      await _saveAndRefresh();
      _showSuccessMessage(AppConstants.depositSuccessMessage);
    }
  }

  Future<void> _handleWithdrawTap() async {
    if (currentUser.wallets.isEmpty) {
      _showErrorMessage(AppConstants.noWalletsMessage);
      return;
    }

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => TransactionDialog(
        type: TransactionDialogType.withdraw,
        wallets: currentUser.wallets,
      ),
    );

    if (result != null && result['success'] == true) {
      await _saveAndRefresh();
      _showSuccessMessage(AppConstants.withdrawSuccessMessage);
    }
  }

  Future<void> _handleTransferTap() async {
    if (currentUser.wallets.length < 2) {
      _showErrorMessage('Transfer için en az 2 cüzdan gereklidir');
      return;
    }

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => TransferDialog(user: currentUser),
    );

    if (result != null && result['success'] == true) {
      await _saveAndRefresh();
      _showSuccessMessage(AppConstants.transferSuccessMessage);
    }
  }

  void _handleWalletsTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            WalletsListScreen(user: currentUser, onUpdate: _saveAndRefresh),
      ),
    );
  }

  Future<void> _handleAddWallet() async {
    if (currentUser.categories.isEmpty) {
      _showErrorMessage('Önce kategori eklemelisiniz');
      return;
    }

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => AddWalletDialog(user: currentUser),
    );

    if (result != null && result['success'] == true) {
      await _saveAndRefresh();
      _showSuccessMessage(AppConstants.walletAddedSuccessMessage);
    }
  }

  Future<void> _saveAndRefresh() async {
    await storageService.saveUser(currentUser);
    await _handleRefresh();
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.positive,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
        ),
      ),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.negative,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
        ),
      ),
    );
  }

  void _showComingSoonSnackBar(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature özelliği yakında eklenecek'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
        ),
      ),
    );
  }
}
