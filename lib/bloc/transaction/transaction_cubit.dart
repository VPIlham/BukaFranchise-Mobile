import 'package:bloc/bloc.dart';
import 'package:bukafranchise/repositories/transaction_repository.dart';
import 'package:equatable/equatable.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final TransactionRepository transactionRepository;

  TransactionCubit({required this.transactionRepository})
      : super(TransactionState.initial());

  Future<void> createTransaction({required data}) async {
    emit(state.copyWith(transactionStatus: TransactionStatus.submitting));
    try {
      print('DATA CUBIT = $data');
      return;
      await transactionRepository.createTransaction(data: data).then((value) {
        if (value.statusCode == 200) {
          emit(state.copyWith(transactionStatus: TransactionStatus.success));
        } else {
          emit(state.copyWith(transactionStatus: TransactionStatus.error));
        }
      });
    } catch (e) {
      emit(state.copyWith(transactionStatus: TransactionStatus.error));
    }
  }
}
