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
      await userRepository.getUser(id: id).then((value) {
        emit(state.copyWith(profileStatus: ProfileStatus.loaded, user: value));
      }).catchError((_) {
        emit(state.copyWith(profileStatus: ProfileStatus.error));
      });
    } catch (e) {
      emit(state.copyWith(
        profileStatus: ProfileStatus.error,
      ));
    }
  }

  Future<void> updateProfile({id, name, phoneNumber, image}) async {
    emit(state.copyWith(profileStatus: ProfileStatus.submitting));
    try {
      final result = await userRepository.updateProfile(
        id: id,
        name: name,
        phoneNumber: phoneNumber,
        image: image,
      );

      if (result.statusCode == 200) {
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
