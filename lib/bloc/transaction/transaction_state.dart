part of 'transaction_cubit.dart';

enum TransactionStatus {
  initial,
  loading,
  submitting,
  success,
  formSuccess,
  error,
}

class TransactionState extends Equatable {
  final TransactionStatus transactionStatus;
  var transactions;
  var transaction;

  TransactionState({
    required this.transactionStatus,
    required this.transactions,
    required this.transaction,
  });

  factory TransactionState.initial() {
    return TransactionState(
      transactionStatus: TransactionStatus.initial,
      transactions: '',
      transaction: '',
    );
  }

  @override
  List<Object> get props => [transactionStatus, transactions, transaction];

  @override
  String toString() =>
      'TransactionState(transactionStatus: $transactionStatus, transactions: $transactions, transaction: $transaction)';

  TransactionState copyWith({
    TransactionStatus? transactionStatus,
    dynamic? transactions,
    dynamic? transaction,
  }) {
    return TransactionState(
      transactionStatus: transactionStatus ?? this.transactionStatus,
      transactions: transactions ?? this.transactions,
      transaction: transaction ?? this.transaction,
    );
  }
}
