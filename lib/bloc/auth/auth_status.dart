part of 'auth_bloc.dart';

class AuthStatus {
  const AuthStatus();
}

class InitialAuthStatus extends AuthStatus {
  const InitialAuthStatus();
}

class Submitting extends AuthStatus {}

class AuthSuccess extends AuthStatus {
  final User data;
  AuthSuccess({required this.data});
}

class AuthError extends AuthStatus {
  final Exception exception;

  AuthError(this.exception);
}

class AuthLogoutSuccess extends AuthStatus {
  final String message;
  AuthLogoutSuccess({required this.message});
}

class AuthLogoutFailed extends AuthStatus {
  final String message;
  AuthLogoutFailed({required this.message});
}
