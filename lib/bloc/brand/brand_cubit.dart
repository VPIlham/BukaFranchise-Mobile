import 'package:bloc/bloc.dart';
import 'package:bukafranchise/repositories/brand_repository.dart';
import 'package:equatable/equatable.dart';

part 'brand_state.dart';

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

  // Future<void> updateBrand({
  //   required String uid,
  //   required String docId,
  //   required String name,
  //   required String category,
  //   required int price,
  //   required String unit,
  //   required String status,
  // }) async {
  //   emit(state.copyWith(brandStatus: BrandStatus.submitting));
  //   try {
  //     await brandRepository.updateBrand(
  //         name: name,
  //         category: category,
  //         price: price,
  //         unit: unit,
  //         status: status,
  //         docId: docId,
  //         uid: uid);
  //     emit(state.copyWith(brandStatus: BrandStatus.formSuccess));
  //   } catch (e) {
  //     emit(state.copyWith(
  //       brandStatus: BrandStatus.error,
  //     ));
  //   }
  // }

  // Future<void> getBrandId({required String uid, required String docId}) async {
  //   try {
  //     await brandRepository
  //         .getBrandById(uid: uid, docId: docId)
  //         .then((value) async {
  //       emit(
  //         state.copyWith(
  //           brandStatus: BrandStatus.loading,
  //           brands: Brand(
  //               uid: value!['doc_id'],
  //               name: value['name'],
  //               category: value['category'],
  //               status: value['status'],
  //               unit: value['unit'],
  //               price: value['price']),
  //         ),
  //       );
  //     });

  //     emit(state.copyWith(brandStatus: BrandStatus.initial));
  //   } catch (e) {
  //     emit(state.copyWith(
  //       brandStatus: BrandStatus.error,
  //     ));
  //   }
  // }

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
