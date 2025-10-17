enum TransactionType {
  deposit,
  withdraw,
  transfer
}

class Transaction {
  final String id;
  final TransactionType type;
  final double amount;
  final DateTime date;
  final String walletId;
  final String? relatedWalletId;

  Transaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.date,
    required this.walletId,
    this.relatedWalletId,
  });

  /** json serializer */
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toString().split('.').last,
      'amount': amount,
      'date': date.toIso8601String(),
      'walletId': walletId,
      'relatedWalletId': relatedWalletId,
    };
  }

  /** json deserializer */
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      type: TransactionType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
      ),
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      walletId: json['walletId'] as String,
      relatedWalletId: json['relatedWalletId'] as String?,
      );
  }

  @override
  String toString() {
    return 'Transaction(id: $id, type: $type, amount: $amount, date: $date)';
  }

}