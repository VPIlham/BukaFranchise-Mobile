part of 'auth_bloc.dart';

class AuthState {
  final String? email;
  final String? password;
  final AuthStatus? formStatus;

  AuthState({this.email, this.password, this.formStatus});

  AuthState copyWith(
      {String? email, String? password, AuthStatus? formStatus}) {
    return AuthState(email: email, password: password, formStatus: formStatus);
  }
}
