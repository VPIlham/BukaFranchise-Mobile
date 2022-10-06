part of 'banner_cubit.dart';

enum BannerStatus { initial, loading, success, error }

class BannerState extends Equatable {
  final BannerStatus bannerStatus;
  final banner;

  const BannerState({
    required this.bannerStatus,
    required this.banner,
  });

  factory BannerState.initial() {
    return const BannerState(
      bannerStatus: BannerStatus.initial,
      banner: '',
    );
  }

  @override
  List<Object> get props => [bannerStatus, banner];

  @override
  String toString() =>
      'BannerState(bannerStatus: $bannerStatus, banner: $banner)';

  BannerState copyWith({
    BannerStatus? bannerStatus,
    dynamic? banner,
  }) {
    return BannerState(
      bannerStatus: bannerStatus ?? this.bannerStatus,
      banner: banner ?? this.banner,
    );
  }
}
