import 'dart:math';
import '../utils/exceptions.dart';
import 'category.dart';
import 'transaction.dart';

class Wallet {
  final String id;
  final String name;
  double balance;
  final Category category;
  final List<Transaction> transactions;

  Wallet({
    required this.id,
    required this.name,
    required this.balance,
    required this.category,
    List<Transaction>? transactions,
  }) : transactions = transactions ?? [];

  void deposit(double amount) {
    if (amount <= 0) {
      throw InvalidAmountException("Depoist amount must be greater than zero.");
    }

    balance += amount;

    transactions.add(
      Transaction(
        id: Random.secure().toString(),
        type: TransactionType.deposit,
        amount: amount,
        date: DateTime.now(),
        walletId: id,
      ),
    );
  }

  void withdraw(double amount) {
    if (amount <= 0) {
      throw InvalidAmountException(
        "Withdraw amount must be greater than zero.",
      );
    }

    if (amount > balance) {
      throw BalanceException("Balance error!");
    }

    balance -= amount;

    transactions.add(
      Transaction(
        id: Random.secure().toString(),
        type: TransactionType.withdraw,
        amount: amount,
        date: DateTime.now(),
        walletId: id,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'balance': balance,
      'category': category.toJson(),
      'transactions': transactions.map((t) => t.toJson()).toList(),
    };
  }

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      id: json['id'] as String,
      name: json['name'] as String? ?? 'Cüzdan',
      balance: (json['balance'] as num).toDouble(),
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      transactions: (json['transactions'] as List<dynamic>?)
          ?.map((t) => Transaction.fromJson(t as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'Wallet(id: $id, name: $name, balance: $balance, category: ${category.name}, transactions: ${transactions.length})';
  }
}
