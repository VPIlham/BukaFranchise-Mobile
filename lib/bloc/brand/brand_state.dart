import 'package:equatable/equatable.dart';

enum BrandStatus {
  initial,
  loading,
  submitting,
  success,
  formSuccess,
  error,
}

class BrandState extends Equatable {
  final BrandStatus brandStatus;
  var brands;
  var brand;

  BrandState({
    required this.brandStatus,
    required this.brands,
    required this.brand,
  });

  factory BrandState.initial() {
    return BrandState(
      brandStatus: BrandStatus.initial,
      brands: '',
      brand: '',
    );
  }

  @override
  List<Object> get props => [brandStatus, brands, brand];

  BrandState copyWith({
    BrandStatus? brandStatus,
    dynamic? brands,
    dynamic? brand,
  }) {
    return BrandState(
      brandStatus: brandStatus ?? this.brandStatus,
      brands: brands ?? this.brands,
      brand: brand ?? this.brand,
    );
  }

  @override
  String toString() =>
      'BrandState(brandStatus: $brandStatus, brands: $brands, brand: $brand)';
}
