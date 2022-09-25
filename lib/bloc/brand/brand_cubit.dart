import 'package:bloc/bloc.dart';
import 'package:bukafranchise/bloc/brand/brand_state.dart';
import 'package:bukafranchise/repositories/brand_repository.dart';

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
      print('RESULT $result');
    } catch (e) {
      print('ERROR DI CATCH');
      emit(state.copyWith(
        brandStatus: BrandStatus.error,
      ));
    }
  }

  Future<void> getBrandId({required int id}) async {
    try {
      emit(state.copyWith(brandStatus: BrandStatus.loading, brand: null));
      await brandRepository.getBrandById(id: id).then((value) async {
        emit(
          state.copyWith(
            brandStatus: BrandStatus.success,
            brand: value.data['data'],
          ),
        );
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
}
