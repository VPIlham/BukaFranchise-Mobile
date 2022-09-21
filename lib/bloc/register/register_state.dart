part of 'register_cubit.dart';

enum RegisterStatus {
  initial,
  submitting,
  success,
  error,
}

class RegisterState extends Equatable {
  final RegisterStatus registerStatus;

  const RegisterState({
    required this.registerStatus,
  });

  factory RegisterState.initial() {
    return const RegisterState(
      registerStatus: RegisterStatus.initial,
    );
  }

  @override
  List<Object> get props => [registerStatus];

  RegisterState copyWith({
    RegisterStatus? registerStatus,
  }) {
    return RegisterState(
      registerStatus: registerStatus ?? this.registerStatus,
    );
  }
}
