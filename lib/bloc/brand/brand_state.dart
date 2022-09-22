part of 'brand_cubit.dart';

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

  BrandState({required this.brandStatus, this.brands});

  factory BrandState.initial() {
    return BrandState(
      brandStatus: BrandStatus.initial,
      brands: '',
    );
  }

  @override
  List<Object> get props => [brandStatus, brands];

  BrandState copyWith({
    BrandStatus? brandStatus,
    dynamic? brands,
  }) {
    return BrandState(
        brandStatus: brandStatus ?? this.brandStatus,
        brands: brands ?? this.brands);
  }

  @override
  String toString() => 'BrandState(brandStatus: $brandStatus, brands: $brands)';
}
