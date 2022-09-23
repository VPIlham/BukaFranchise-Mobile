part of 'profile_cubit.dart';

enum ProfileStatus { initial, loading, submitting, loaded, formSuccess, error }

class ProfileState extends Equatable {
  final ProfileStatus profileStatus;
  final User user;

  const ProfileState({
    required this.profileStatus,
    required this.user,
  });

  factory ProfileState.initial() {
    return ProfileState(
      profileStatus: ProfileStatus.initial,
      user: User.initialUser(),
    );
  }

  @override
  List<Object> get props => [profileStatus, user];

  ProfileState copyWith({
    ProfileStatus? profileStatus,
    User? user,
  }) {
    return ProfileState(
      profileStatus: profileStatus ?? this.profileStatus,
      user: user ?? this.user,
    );
  }

  @override
  String toString() =>
      'ProfileState(profileStatus: $profileStatus, user: $user)';
}
