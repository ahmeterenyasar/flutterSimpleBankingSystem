class AppExceptions implements Exception {
  final String message;
  AppExceptions(this.message);

  @override
  String toString() => "EXCEPTION: $message";
}

class InvalidAmountException extends AppExceptions {
  InvalidAmountException(super.message);

  @override
  String toString() => "InvalidAmountException: $message";
}

class BalanceException extends AppExceptions {
  BalanceException(super.message);

  @override
  String toString() => 'BalanceException: $message';
}

class WalletNotFoundException extends AppExceptions {
  WalletNotFoundException(super.message);

  @override
  String toString() => 'WalletNotFoundException: $message';
}

class InvalidTransferException extends AppExceptions {
  InvalidTransferException(super.message);

  @override
  String toString() => 'InvalidTransferException: $message';
}
