import 'package:bloc/bloc.dart';
import 'package:bukafranchise/models/user.dart';
import 'package:bukafranchise/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository userRepository;

  ProfileCubit({required this.userRepository}) : super(ProfileState.initial());

  Future<void> getProfile({required var id}) async {
    emit(state.copyWith(profileStatus: ProfileStatus.loading));

    try {
      final User user = await userRepository.getUser(id: id);
      emit(state.copyWith(profileStatus: ProfileStatus.loaded, user: user));
    } catch (e) {
      emit(state.copyWith(
        profileStatus: ProfileStatus.error,
      ));
    }
  }
}
