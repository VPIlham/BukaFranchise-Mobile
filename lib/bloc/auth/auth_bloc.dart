import 'package:bloc/bloc.dart';
import 'package:bukafranchise/models/user.dart';
import 'package:bukafranchise/repositories/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_status.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserServices userServices;
  AuthBloc({required this.userServices}) : super(AuthState()) {
    on<AuthSubmitted>(authSubmit);
    on<AuthLogout>(authLogout);
  }

  void authSubmit(AuthSubmitted event, Emitter<AuthState> emit) async {
    emit(state.copyWith(formStatus: const InitialAuthStatus()));
    try {
      User data = await userServices.authLogin(
          email: event.email, password: event.password);
      emit(state.copyWith(formStatus: AuthSuccess(data: data)));
    } on Exception catch (ex) {
      emit(state.copyWith(formStatus: AuthError(ex)));
    }
  }

  void authLogout(AuthLogout event, Emitter<AuthState> emit) async {
    emit(state.copyWith(formStatus: const InitialAuthStatus()));
    try {
      User data = await userServices.authLogout();
      // if (data.code == 200) {
      //   emit(state.copyWith(
      //       formStatus: AuthLogoutSuccess(message: data.message)));
      // } else {
      //   emit(state.copyWith(
      //       formStatus: AuthLogoutFailed(message: data.message)));
      // }
    } on Exception catch (ex) {
      emit(state.copyWith(formStatus: AuthError(ex)));
    }
  }
}
