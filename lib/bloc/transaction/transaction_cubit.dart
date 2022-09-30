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

      await transactionRepository.createTransaction(data: data).then((value) {
        if (value.statusCode == 200) {
          emit(
              state.copyWith(transactionStatus: TransactionStatus.formSuccess));
        } else {
          emit(state.copyWith(transactionStatus: TransactionStatus.error));
        }
      });
    } catch (e) {
      emit(state.copyWith(transactionStatus: TransactionStatus.error));
    }
  }

  Future<void> updateTransaction({required data, required id}) async {
    emit(state.copyWith(transactionStatus: TransactionStatus.submitting));
    try {
      print('DATA CUBIT = $data');

      await transactionRepository
          .updateTransaction(data: data, id: id)
          .then((value) {
        if (value.statusCode == 200) {
          emit(
              state.copyWith(transactionStatus: TransactionStatus.formSuccess));
        } else {
          emit(state.copyWith(transactionStatus: TransactionStatus.error));
        }
      });
    } catch (e) {
      emit(state.copyWith(transactionStatus: TransactionStatus.error));
    }
  }

  Future<void> getListorderById(
      {String? search,
      int? pageSize,
      String? direction,
      String? status}) async {
    emit(state.copyWith(transactionStatus: TransactionStatus.loading));
    try {
      await transactionRepository
          .getListorderById(
        search: search,
        pageSize: pageSize,
        direction: direction,
        status: status,
      )
          .then((value) {
        if (value.statusCode == 200) {
          final data = value.data['data'];
          emit(state.copyWith(
              transactionStatus: TransactionStatus.success,
              transactions: data));
        } else {
          emit(state.copyWith(transactionStatus: TransactionStatus.error));
        }
      });
    } catch (e) {
      emit(state.copyWith(transactionStatus: TransactionStatus.error));
    }
  }

  Future<void> getOrderById({required id}) async {
    emit(state.copyWith(transactionStatus: TransactionStatus.loading));
    try {
      await transactionRepository.getOrderById(id: id).then((value) {
        if (value.statusCode == 200) {
          final data = value.data['data'];

          emit(state.copyWith(
              transactionStatus: TransactionStatus.success, transaction: data));
        } else {
          emit(state.copyWith(transactionStatus: TransactionStatus.error));
        }
      });
    } catch (e) {
      emit(state.copyWith(transactionStatus: TransactionStatus.error));
    }
  }

  Future<void> getListWithdraw(
      {String? search,
      int? pageSize,
      String? direction,
      String? sort,
      String? status}) async {
    emit(state.copyWith(transactionStatus: TransactionStatus.loading));
    try {
      await transactionRepository
          .getListWithdraw(
        pageSize: pageSize,
        direction: direction,
        sort: sort,
        status: status,
      )
          .then((value) {
        if (value.statusCode == 200) {
          final data = value.data['data'];
          print('DATA C WITHDRAW = $data');
          emit(state.copyWith(
              transactionStatus: TransactionStatus.success, withdraws: data));
        } else {
          emit(state.copyWith(transactionStatus: TransactionStatus.error));
        }
      });
    } catch (e) {
      emit(state.copyWith(transactionStatus: TransactionStatus.error));
    }
  }

  Future<void> createWithdraw({required data}) async {
    emit(state.copyWith(transactionStatus: TransactionStatus.submitting));
    try {
      print('DATA CUBIT = $data');

      await transactionRepository.createWithdraw(data: data).then((value) {
        if (value.statusCode == 200) {
          emit(
              state.copyWith(transactionStatus: TransactionStatus.formSuccess));
        } else {
          emit(state.copyWith(
              transactionStatus: TransactionStatus.errorWithdraw,
              errorMsg: value.data["message"]));
        }
      });
    } catch (e) {
      emit(state.copyWith(transactionStatus: TransactionStatus.errorWithdraw));
    }
  }
}
