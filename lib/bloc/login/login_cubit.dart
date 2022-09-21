import 'package:bloc/bloc.dart';
import 'package:bukafranchise/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;
  LoginCubit({required this.authRepository}) : super(LoginState.initial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(loginStatus: LoginStatus.submitting));
    try {
      print('cubit = $email & $password');
      await authRepository.login(email: email, password: password);
      emit(state.copyWith(loginStatus: LoginStatus.success));
    } catch (e) {
      emit(state.copyWith(
        loginStatus: LoginStatus.error,
      ));
    }
  }
}
