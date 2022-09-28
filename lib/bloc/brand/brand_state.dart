import 'package:equatable/equatable.dart';

enum BrandStatus {
  initial,
  loading,
  submitting,
  success,
  formSuccess,
  error,
  successLiked,
  successRemoveLiked,
  loadingWishlist,
  errorWishlist
}

class BrandState extends Equatable {
  final BrandStatus brandStatus;
  var brands;
  var brand;
  bool isLiked = false;
  List<dynamic> brandItems;

  BrandState({
    required this.brandStatus,
    required this.brands,
    required this.brand,
    required this.isLiked,
    required this.brandItems,
  });

  factory BrandState.initial() {
    return BrandState(
        brandStatus: BrandStatus.initial,
        brands: '',
        brand: '',
        brandItems: const [],
        isLiked: false);
  }

  @override
  List<Object> get props => [brandStatus, brands, brand, isLiked, brandItems];

  BrandState copyWith(
      {BrandStatus? brandStatus,
      dynamic? brands,
      dynamic? brand,
      List<dynamic>? brandItems,
      bool? isLiked}) {
    return BrandState(
        brandStatus: brandStatus ?? this.brandStatus,
        brands: brands ?? this.brands,
        brand: brand ?? this.brand,
        brandItems: brandItems ?? this.brandItems,
        isLiked: isLiked ?? this.isLiked);
  }

  @override
  String toString() =>
      'BrandState(brandStatus: $brandStatus, brands: $brands, brand: $brand)';
}
