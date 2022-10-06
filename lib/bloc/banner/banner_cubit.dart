import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bukafranchise/repositories/user_repository.dart';

part 'banner_state.dart';

class BannerCubit extends Cubit<BannerState> {
  final UserRepository userRepository;
  BannerCubit({required this.userRepository}) : super(BannerState.initial());

  Future<void> getBanner() async {
    emit(state.copyWith(bannerStatus: BannerStatus.loading));
    try {
      await userRepository.getBanner().then((value) {
        print("RESPONSE BANNER = $value");
        if (value.statusCode == 200) {
          final data = value.data['data'];
          emit(
              state.copyWith(bannerStatus: BannerStatus.success, banner: data));
        } else {
          emit(state.copyWith(bannerStatus: BannerStatus.error));
        }
      });
    } catch (e) {
      emit(state.copyWith(
        bannerStatus: BannerStatus.error,
      ));
    }
  }
}
