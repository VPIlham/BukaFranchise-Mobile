part of 'banner_cubit.dart';

enum BannerStatus { initial, loading, success, error }

class BannerState extends Equatable {
  final BannerStatus bannerStatus;
  final banner;
  List<dynamic> banners;

  BannerState(
      {required this.bannerStatus,
      required this.banner,
      required this.banners});

  factory BannerState.initial() {
    return BannerState(
        bannerStatus: BannerStatus.initial, banner: '', banners: const []);
  }

  @override
  List<Object> get props => [bannerStatus, banner, banners];

  @override
  String toString() =>
      'BannerState(bannerStatus: $bannerStatus, banner: $banner, banners $banners)';

  BannerState copyWith(
      {BannerStatus? bannerStatus, dynamic? banner, List<dynamic>? banners}) {
    return BannerState(
        bannerStatus: bannerStatus ?? this.bannerStatus,
        banner: banner ?? this.banner,
        banners: banners ?? this.banners);
  }
}
