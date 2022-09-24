import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int? id;
  final String? name;
  final int? price;
  final String? description;

  Product({
    this.id,
    this.name,
    this.price,
    this.description,
  });

  @override
  List<Object?> get props => [id, name, price, description];

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, description: $description)';
  }

  Product copyWith({
    int? id,
    String? name,
    int? price,
    String? description,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
    );
  }
}
