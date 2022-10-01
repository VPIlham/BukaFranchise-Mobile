import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bukafranchise/repositories/user_repository.dart';

part 'mostsold_state.dart';

class MostsoldCubit extends Cubit<MostSoldState> {
  final UserRepository userRepository;
  MostsoldCubit({required this.userRepository})
      : super(MostSoldState.initial());

  Future<void> getMostSoldItem() async {
    emit(state.copyWith(mostSoldStatus: MostSoldStatus.loading));
    try {
      await userRepository.getMostSoldItem().then((value) {
        print("RESPONSE MOST SOLD = $value");
        if (value.statusCode == 200) {
          final data = value.data['data'];
          emit(state.copyWith(
              mostSoldStatus: MostSoldStatus.success, mostsold: data));
        } else {
          emit(state.copyWith(mostSoldStatus: MostSoldStatus.error));
        }
      });
    } catch (e) {
      emit(state.copyWith(
        mostSoldStatus: MostSoldStatus.error,
      ));
    }
  }
}
