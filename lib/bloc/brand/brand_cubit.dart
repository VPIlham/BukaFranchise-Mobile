import 'package:bloc/bloc.dart';
import 'package:bukafranchise/bloc/brand/brand_state.dart';
import 'package:bukafranchise/repositories/brand_repository.dart';
import 'package:bukafranchise/repositories/user_repository.dart';

class BrandCubit extends Cubit<BrandState> {
  final BrandRepository brandRepository;

  BrandCubit({
    required this.brandRepository,
  }) : super(BrandState.initial());

  Future<void> getAllBrand() async {
    emit(state.copyWith(brandStatus: BrandStatus.loading));
    try {
      await brandRepository.getAllBrand().then((value) {
        // print("STATUS KODE NYA = ${value.statusCode}");
        if (value.statusCode == 200) {
          final data = value.data['data'];
          emit(state.copyWith(brandStatus: BrandStatus.success, brands: data));
        } else {
          emit(state.copyWith(brandStatus: BrandStatus.error));
        }
      }).catchError((_) {
        emit(state.copyWith(brandStatus: BrandStatus.error));
      });
    } catch (e) {
      emit(state.copyWith(
        brandStatus: BrandStatus.error,
      ));
    }
  }

  Future<void> updateBrand({required id, var data, image}) async {
    emit(state.copyWith(brandStatus: BrandStatus.submitting));
    try {
      final result =
          await brandRepository.updateBrand(id: id, data: data, image: image);

      if (result.statusCode == 200) {
        emit(state.copyWith(
          brandStatus: BrandStatus.formSuccess,
        ));
      } else {
        emit(state.copyWith(
          brandStatus: BrandStatus.error,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        brandStatus: BrandStatus.error,
      ));
    }
  }

  Future<void> getBrandId({required int id}) async {
    emit(state.copyWith(brandStatus: BrandStatus.loading, isLiked: false));
    try {
      await brandRepository.getBrandById(id: id).then((value) async {
        if (value.statusCode == 200) {
          final data = value.data['data'];
          emit(state.copyWith(
              brandStatus: BrandStatus.success,
              brand: data,
              isLiked: data?["currentUserLiked"] ?? false));
        } else {
          emit(state.copyWith(brandStatus: BrandStatus.error));
        }
      }).catchError((_) {
        emit(state.copyWith(brandStatus: BrandStatus.error));
      });
    } catch (e) {
      emit(state.copyWith(
        brandStatus: BrandStatus.error,
      ));
    }
  }

  // Future<void> deleteBrand({required String uid, required String docId}) async {
  //   emit(
  //     state.copyWith(brandStatus: BrandStatus.loading),
  //   );
  //   try {
  //     await brandRepository
  //         .deleteBrand(uid: uid, docId: docId)
  //         .then((value) async {
  //       emit(state.copyWith(brandStatus: BrandStatus.formSuccess));
  //     });
  //   } catch (e) {
  //     emit(state.copyWith(
  //       brandStatus: BrandStatus.error,
  //     ));
  //   }
  // }

  Future<void> postWishlist({required id}) async {
    emit(state.copyWith(brandStatus: BrandStatus.loadingWishlist));
    try {
      await brandRepository.postWishlist(id: id).then((value) {
        print("RESPONSE POST WISHLIST = $value");
        if (value.statusCode == 200) {
          emit(state.copyWith(
              brandStatus: BrandStatus.successLiked, isLiked: true));
        } else {
          emit(state.copyWith(brandStatus: BrandStatus.errorWishlist));
        }
      });
    } catch (e) {
      emit(state.copyWith(brandStatus: BrandStatus.errorWishlist));
    }
  }

  Future<void> removeWishlist({required id}) async {
    emit(state.copyWith(brandStatus: BrandStatus.loadingWishlist));
    try {
      await brandRepository.removeWishlist(id: id).then((value) {
        print("RESPONSE POST WISHLIST = $value");
        if (value.statusCode == 200) {
          emit(state.copyWith(
              brandStatus: BrandStatus.successRemoveLiked, isLiked: false));
        } else {
          emit(state.copyWith(brandStatus: BrandStatus.errorWishlist));
        }
      });
    } catch (e) {
      emit(state.copyWith(brandStatus: BrandStatus.errorWishlist));
    }
  }

  Future<void> getAllBrandItems() async {
    emit(state.copyWith(brandStatus: BrandStatus.loading));
    try {
      await brandRepository.getAllBrandItems().then((value) {
        print("STATUS KODE NYA = ${value}");
        if (value.statusCode == 200) {
          final data = value.data['data'];
          emit(state.copyWith(
              brandStatus: BrandStatus.success, brandItems: data));
        } else {
          emit(state.copyWith(brandStatus: BrandStatus.error));
        }
      }).catchError((_) {
        emit(state.copyWith(brandStatus: BrandStatus.error));
      });
    } catch (e) {
      emit(state.copyWith(
        brandStatus: BrandStatus.error,
      ));
    }
  }
}
