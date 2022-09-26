part of 'wishlist_cubit.dart';

enum WishlistStatus { initial, loading, success, error }

class WishlistState extends Equatable {
  final WishlistStatus wishlistStatus;
  final detailWishlist;
  final wishlist;

  const WishlistState({
    required this.wishlistStatus,
    required this.detailWishlist,
    required this.wishlist,
  });

  factory WishlistState.initial() {
    return const WishlistState(
      wishlistStatus: WishlistStatus.initial,
      detailWishlist: '',
      wishlist: '',
    );
  }

  @override
  List<Object> get props => [wishlistStatus, wishlist, detailWishlist];

  @override
  String toString() =>
      'WishlistState(wishlistStatus: $wishlistStatus, wishlist: $wishlist, detailWishlist : $detailWishlist)';

  WishlistState copyWith({
    WishlistStatus? wishlistStatus,
    dynamic? wishlist,
    dynamic? detailWishlist,
  }) {
    return WishlistState(
      wishlistStatus: wishlistStatus ?? this.wishlistStatus,
      wishlist: wishlist ?? this.wishlist,
      detailWishlist: detailWishlist ?? this.detailWishlist,
    );
  }
}
