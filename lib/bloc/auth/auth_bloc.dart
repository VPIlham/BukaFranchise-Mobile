import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bukafranchise/models/user.dart';
import 'package:bukafranchise/repositories/auth_repository.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthRepository authRepository,
  })  : _authenticationRepository = authRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  final AuthRepository _authenticationRepository;

  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  Future<void> _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    print('EVENT STATUS = ${event.status}');
    switch (event.status) {
      case AuthenticationStatus.error:
        return emit(const AuthenticationState.error());
      case AuthenticationStatus.submitting:
        return emit(const AuthenticationState.submitting());
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        print('TIPE DATA USER = $user ');
        return emit(
          user != null
              ? AuthenticationState.authenticated(user)
              : const AuthenticationState.unauthenticated(),
        );
      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    _authenticationRepository.logOut();
  }

  _tryGetUser() async {
    try {
      final userId = await getUserId();
      final name = await getNameUser();
      final role = await getRoleUser();
      final email = await getEmailUser();
      print(
          'USER ID = $userId \n Name = $name \n Role = $role \n Email = $email');
      return User(id: int.parse(userId), name: name, role: role, email: email);
    } catch (err) {
      print('ERROR = $err');
    }
  }
}
