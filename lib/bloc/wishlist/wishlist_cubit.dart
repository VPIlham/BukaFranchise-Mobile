import 'package:bloc/bloc.dart';
import 'package:bukafranchise/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final UserRepository userRepository;
  WishlistCubit({required this.userRepository})
      : super(WishlistState.initial());

  Future<void> getAllWishlist() async {
    emit(state.copyWith(wishlistStatus: WishlistStatus.loading));
    try {
      await userRepository.getAllWishlist().then((value) {
        print("RESPONSE WISHLIST = $value");
        if (value.statusCode == 200) {
          final data = value.data['data'];
          emit(state.copyWith(
              wishlistStatus: WishlistStatus.success, wishlist: data));
        } else {
          emit(state.copyWith(wishlistStatus: WishlistStatus.error));
        }
      });
    } catch (e) {
      emit(state.copyWith(
        wishlistStatus: WishlistStatus.error,
      ));
    }
  }
}
