part of 'product_cubit.dart';

enum ProductStatus {
  initial,
  loading,
  loaded,
  success,
  error,
  formSuccess,
  submitting
}

class ProductState extends Equatable {
  final ProductStatus productStatus;
  var product;
  var products;

  ProductState({
    required this.productStatus,
    required this.product,
    required this.products,
  });

  factory ProductState.initial() {
    return ProductState(
      productStatus: ProductStatus.initial,
      product: '',
      products: '',
    );
  }

  @override
  List<Object> get props => [productStatus, product, products];

  ProductState copyWith({
    ProductStatus? productStatus,
    dynamic? product,
    dynamic? products,
  }) {
    return ProductState(
      productStatus: productStatus ?? this.productStatus,
      product: product ?? this.product,
      products: products ?? this.products,
    );
  }

  @override
  String toString() =>
      'ProductState(productStatus: $productStatus, product: $product, products: $products)';
}
