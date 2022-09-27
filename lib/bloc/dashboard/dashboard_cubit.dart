import 'package:bloc/bloc.dart';
import 'package:bukafranchise/models/dashboard.dart';
import 'package:bukafranchise/repositories/user_repository.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final UserRepository userRepository;
  DashboardCubit({required this.userRepository})
      : super(DashboardState.initial());

  Future<void> getSummary() async {
    emit(state.copyWith(dashboardStatus: DashboardStatus.loading));
    try {
      await userRepository.getSummary().then((value) {
        if (value.statusCode == 200) {
          final data = value.data['data'];
          print('MY DATA DASHBOARD =  $data');
          emit(state.copyWith(
              dashboardStatus: DashboardStatus.success, dashboard: data));
        } else {
          emit(state.copyWith(dashboardStatus: DashboardStatus.error));
        }
      }).catchError((_) {
        emit(state.copyWith(dashboardStatus: DashboardStatus.error));
      });
    } catch (e) {
      emit(state.copyWith(
        dashboardStatus: DashboardStatus.error,
      ));
    }
  }
}
