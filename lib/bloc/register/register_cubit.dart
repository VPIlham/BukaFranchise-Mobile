import 'package:bloc/bloc.dart';
import 'package:bukafranchise/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository authRepository;

  RegisterCubit({
    required this.authRepository,
  }) : super(RegisterState.initial());

  Future<void> register({
    required String? name,
    required String? email,
    required String? password,
    required String? role,
    int? totalEmployee,
    String? nameBrand,
    String? startOperation,
    String? categoryBrand,
  }) async {
    emit(state.copyWith(registerStatus: RegisterStatus.submitting));
    try {
      await authRepository.register(
        email: email,
        name: name,
        password: password,
        role: role,
        totalEmployee: totalEmployee,
        nameBrand: nameBrand,
        startOperation: startOperation,
        categoryBrand: categoryBrand,
      );
      emit(state.copyWith(registerStatus: RegisterStatus.success));
    } catch (e) {
      emit(state.copyWith(registerStatus: RegisterStatus.error));
    }
  }
}
