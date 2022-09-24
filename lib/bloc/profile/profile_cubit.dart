import 'package:bloc/bloc.dart';
import 'package:bukafranchise/models/user.dart';
import 'package:bukafranchise/repositories/auth_repository.dart';
import 'package:bukafranchise/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository userRepository;

  ProfileCubit({required this.userRepository}) : super(ProfileState.initial());

  Future<void> getProfile({required var id}) async {
    emit(state.copyWith(profileStatus: ProfileStatus.loading));
    try {
      await userRepository.getUser(id: id).then((value) {
        emit(state.copyWith(profileStatus: ProfileStatus.loaded, user: value));
      });
    } catch (e) {
      print('ERROR = $e');
      emit(state.copyWith(
        profileStatus: ProfileStatus.error,
      ));
    }
  }

  Future<void> updateProfile(
      {required id, name, phoneNumber, image, imageId}) async {
    emit(state.copyWith(profileStatus: ProfileStatus.submitting));
    try {
      final result = await userRepository.updateProfile(
          id: id, name: name, phoneNumber: phoneNumber, image: image);

      if (result.statusCode == 200) {
        final authRepository = AuthRepository();
        authRepository.setName(name);
        emit(state.copyWith(
          profileStatus: ProfileStatus.formSuccess,
        ));
      } else {
        emit(state.copyWith(
          profileStatus: ProfileStatus.error,
        ));
      }
      print('RESULT $result');
    } catch (e) {
      print('ERROR DI CATCH');
      emit(state.copyWith(
        profileStatus: ProfileStatus.error,
      ));
    }
  }
}
