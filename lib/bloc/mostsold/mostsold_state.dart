part of 'mostsold_cubit.dart';

enum MostSoldStatus { initial, loading, success, error }

class MostSoldState extends Equatable {
  final MostSoldStatus mostSoldStatus;
  final mostsold;

  const MostSoldState({
    required this.mostSoldStatus,
    required this.mostsold,
  });

  factory MostSoldState.initial() {
    return const MostSoldState(
      mostSoldStatus: MostSoldStatus.initial,
      mostsold: '',
    );
  }

  @override
  List<Object> get props => [mostSoldStatus, mostsold];

  @override
  String toString() =>
      'MostSoldState(mostSoldStatus: $mostSoldStatus, mostsold: $mostsold)';

  MostSoldState copyWith({
    MostSoldStatus? mostSoldStatus,
    dynamic? mostsold,
  }) {
    return MostSoldState(
      mostSoldStatus: mostSoldStatus ?? this.mostSoldStatus,
      mostsold: mostsold ?? this.mostsold,
    );
  }
}
