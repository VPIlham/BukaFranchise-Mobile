import 'package:bloc/bloc.dart';
import 'package:bukafranchise/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;
  ProductCubit({required this.productRepository})
      : super(ProductState.initial());

  Future<void> addProduct({required data, required image}) async {
    emit(state.copyWith(productStatus: ProductStatus.submitting));
    try {
      final result =
          await productRepository.addProduct(data: data, image: image);
      if (result.statusCode == 200) {
        emit(state.copyWith(
          productStatus: ProductStatus.formSuccess,
        ));
      } else {
        emit(state.copyWith(
          productStatus: ProductStatus.error,
        ));
      }
    } catch (e) {
      emit(state.copyWith(productStatus: ProductStatus.error));
    }
  }

  Future<void> deleteProduct({required id}) async {
    try {
      final result = await productRepository.deleteProduct(id: id);
      if (result.statusCode == 200) {
        emit(state.copyWith(
          productStatus: ProductStatus.formSuccess,
        ));
      } else {
        emit(state.copyWith(
          productStatus: ProductStatus.error,
        ));
      }
    } catch (e) {
      emit(state.copyWith(productStatus: ProductStatus.error));
    }
  }

  Future<void> updateProduct({required id, required data, image}) async {
    emit(state.copyWith(productStatus: ProductStatus.submitting));
    try {
      final result = await productRepository.updateProduct(
          id: id, data: data, image: image);
      if (result.statusCode == 200) {
        emit(state.copyWith(
          productStatus: ProductStatus.formSuccess,
        ));
      } else {
        emit(state.copyWith(
          productStatus: ProductStatus.error,
        ));
      }
    } catch (e) {
      emit(state.copyWith(productStatus: ProductStatus.error));
    }
  }

  Future<void> getProductId({required id}) async {
    emit(state.copyWith(productStatus: ProductStatus.loading));
    try {
      final result = await productRepository.getProductId(id: id);
      print('getProductId = $result');
      if (result.statusCode == 200) {
        emit(state.copyWith(
          productStatus: ProductStatus.loaded,
          product: result.data['data'],
        ));
      } else {
        emit(state.copyWith(
          productStatus: ProductStatus.error,
        ));
      }
    } catch (e) {
      emit(state.copyWith(productStatus: ProductStatus.error));
    }
  }

  Future<void> getMyProduct() async {
    emit(state.copyWith(productStatus: ProductStatus.loading));
    try {
      final result = await productRepository.getMyProduct();
      if (result.statusCode == 200) {
        emit(state.copyWith(
          productStatus: ProductStatus.loaded,
          products: result.data['data'],
        ));
      } else {
        emit(state.copyWith(
          productStatus: ProductStatus.error,
        ));
      }
    } catch (e) {
      emit(state.copyWith(productStatus: ProductStatus.error));
    }
  }
}
