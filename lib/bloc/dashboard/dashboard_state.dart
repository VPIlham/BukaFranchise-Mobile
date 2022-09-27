part of 'dashboard_cubit.dart';

enum DashboardStatus { initial, loading, success, error }

class DashboardState extends Equatable {
  final DashboardStatus dashboardStatus;
  final dashboard;

  const DashboardState({
    required this.dashboardStatus,
    required this.dashboard,
  });

  factory DashboardState.initial() {
    return const DashboardState(
      dashboardStatus: DashboardStatus.initial,
      dashboard: '',
    );
  }

  @override
  List<Object> get props => [dashboardStatus, dashboard];

  @override
  String toString() =>
      'DashboardState(dashboardStatus: $dashboardStatus, dashboard: $dashboard)';

  DashboardState copyWith({
    DashboardStatus? dashboardStatus,
    dynamic? dashboard,
  }) {
    return DashboardState(
      dashboardStatus: dashboardStatus ?? this.dashboardStatus,
      dashboard: dashboard ?? this.dashboard,
    );
  }
}
