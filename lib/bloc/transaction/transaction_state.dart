part of 'transaction_cubit.dart';

enum TransactionStatus {
  initial,
  loading,
  submitting,
  success,
  formSuccess,
  error,
  errorWithdraw,
}

class TransactionState extends Equatable {
  final TransactionStatus transactionStatus;
  var transactions;
  var transaction;
  List<dynamic> withdraws;
  var errorMsg;

  TransactionState({
    required this.transactionStatus,
    required this.transactions,
    required this.transaction,
    required this.withdraws,
    required this.errorMsg,
  });

  factory TransactionState.initial() {
    return TransactionState(
        transactionStatus: TransactionStatus.initial,
        transactions: '',
        transaction: '',
        errorMsg: '',
        withdraws: const []);
  }

  @override
  List<Object> get props =>
      [transactionStatus, transactions, transaction, withdraws, errorMsg];

  @override
  String toString() =>
      'TransactionState(transactionStatus: $transactionStatus, transactions: $transactions, transaction: $transaction, withdraws $withdraws)';

  TransactionState copyWith(
      {TransactionStatus? transactionStatus,
      dynamic? transactions,
      dynamic? transaction,
      dynamic? errorMsg,
      List<dynamic>? withdraws}) {
    return TransactionState(
      transactionStatus: transactionStatus ?? this.transactionStatus,
      transactions: transactions ?? this.transactions,
      transaction: transaction ?? this.transaction,
      withdraws: withdraws ?? this.withdraws,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
