import 'package:equatable/equatable.dart';

enum BrandStatus {
  initial,
  loading,
  submitting,
  success,
  formSuccess,
  error,
  successLiked,
  successRemoveLiked
}

class BrandState extends Equatable {
  final BrandStatus brandStatus;
  var brands;
  var brand;
  bool isLiked = false;

  BrandState(
      {required this.brandStatus,
      required this.brands,
      required this.brand,
      required this.isLiked});

  factory BrandState.initial() {
    return BrandState(
        brandStatus: BrandStatus.initial,
        brands: '',
        brand: '',
        isLiked: false);
  }

  @override
  List<Object> get props => [brandStatus, brands, brand, isLiked];

  BrandState copyWith(
      {BrandStatus? brandStatus,
      dynamic? brands,
      dynamic? brand,
      bool? isLiked}) {
    return BrandState(
        brandStatus: brandStatus ?? this.brandStatus,
        brands: brands ?? this.brands,
        brand: brand ?? this.brand,
        isLiked: isLiked ?? this.isLiked);
  }

  @override
  String toString() =>
      'BrandState(brandStatus: $brandStatus, brands: $brands, brand: $brand)';
}
