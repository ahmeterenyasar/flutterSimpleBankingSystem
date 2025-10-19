import 'dart:math';
import 'transaction.dart';
import 'wallet.dart';
import 'category.dart';
import '../utils/exceptions.dart';

class User {
  final String name;
  final String surname;
  final List<Wallet> wallets;
  final List<Category> categories;

  User({
    required this.name,
    required this.surname,
    List<Wallet>? wallets,
    List<Category>? categories,
  }) : wallets = wallets ?? [],
       categories = categories ?? [];

  String getFullName() => '$name $surname';

  int getWalletCount() => wallets.length;

  double getTotalBalance() {
    return wallets.fold(0.0, (sum, wallet) => sum + wallet.balance);
  }

  List<Wallet> getWalletsByCategory(Category category) {
    return wallets
        .where((wallet) => wallet.category.id == category.id)
        .toList();
  }

  void transfer({
    required Wallet fromWallet,
    required Wallet toWallet,
    required double amount,
  }) {
    if (amount <= 0) {
      throw InvalidAmountException("Transfer amount must be grater than 0");
    }

    if (!wallets.contains(fromWallet) || !wallets.contains(toWallet)) {
      throw InvalidTransferException("Wallet not found");
    }

    if (fromWallet.id == toWallet.id) {
      throw InvalidTransferException("Same wallet transfer is forbidden");
    }

    try {
      fromWallet.withdraw(amount);
      toWallet.deposit(amount);
      final transferId = Random.secure();

      fromWallet.transactions.add(
        Transaction(
          id: '$transferId-out',
          type: TransactionType.transfer,
          amount: amount,
          date: DateTime.now(),
          walletId: fromWallet.id,
          relatedWalletId: toWallet.id,
        ),
      );

      toWallet.transactions.add(
        Transaction(
          id: '$transferId-in',
          type: TransactionType.transfer,
          amount: amount,
          date: DateTime.now(),
          walletId: toWallet.id,
          relatedWalletId: fromWallet.id,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  void addCategory(Category category) {
    if (!categories.any((c) => c.id == category.id)) {
      categories.add(category);
    }
  }

  void addWallet(Wallet wallet) {
    if (!categories.any((c) => c.id == wallet.category.id)) {
      categories.add(wallet.category);
    }
    wallets.add(wallet);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'wallets': wallets.map((w) => w.toJson()).toList(),
      'categories': categories.map((c) => c.toJson()).toList(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      surname: json['surname'] as String,
      wallets: (json['wallets'] as List<dynamic>?)
          ?.map((w) => Wallet.fromJson(w as Map<String, dynamic>))
          .toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((c) => Category.fromJson(c as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'User(name: ${getFullName()}, wallets: ${getWalletCount()}, totalBalance: ${getTotalBalance()})';
  }
}
