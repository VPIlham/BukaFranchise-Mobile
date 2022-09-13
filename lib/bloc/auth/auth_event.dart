part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthSubmitted extends AuthEvent {
  final String? email;
  final String? password;

  AuthSubmitted({this.email, this.password});
}

class AuthLogout extends AuthEvent {
  AuthLogout();
}
