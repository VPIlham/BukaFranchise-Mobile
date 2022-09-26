part of 'dashboard_cubit.dart';

enum DashboardStatus { initial, loading, success, error }

class DashboardState extends Equatable {
  final DashboardStatus dashboardStatus;
  final Dashboard dashboard;

  const DashboardState({
    required this.dashboardStatus,
    required this.dashboard,
  });

  factory DashboardState.initial() {
    return DashboardState(
      dashboardStatus: DashboardStatus.initial,
      dashboard: Dashboard.initialDashboard(),
    );
  }

  @override
  List<Object> get props => [dashboardStatus, dashboard];

  @override
  String toString() =>
      'DashboardState(dashboardStatus: $dashboardStatus, dashboard: $dashboard)';

  DashboardState copyWith({
    DashboardStatus? dashboardStatus,
    Dashboard? dashboard,
  }) {
    return DashboardState(
      dashboardStatus: dashboardStatus ?? this.dashboardStatus,
      dashboard: dashboard ?? this.dashboard,
    );
  }
}
