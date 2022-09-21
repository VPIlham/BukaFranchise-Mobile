import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? password;
  final String? phoneNumber;
  final String? image;
  final String? role;
  final int? totalEmployee;
  final String? nameBrand;
  final String? startOperation;
  final String? categoryBrand;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.phoneNumber,
    this.image,
    this.role,
    this.totalEmployee,
    this.nameBrand,
    this.startOperation,
    this.categoryBrand,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      email,
      password,
      phoneNumber,
      image,
      role,
      totalEmployee,
      nameBrand,
      startOperation,
      categoryBrand,
    ];
  }

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? password,
    String? phoneNumber,
    String? image,
    String? role,
    int? totalEmployee,
    String? nameBrand,
    String? startOperation,
    String? categoryBrand,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      image: image ?? this.image,
      role: role ?? this.role,
      totalEmployee: totalEmployee ?? this.totalEmployee,
      nameBrand: nameBrand ?? this.nameBrand,
      startOperation: startOperation ?? this.startOperation,
      categoryBrand: categoryBrand ?? this.categoryBrand,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, password: $password, phoneNumber: $phoneNumber, image: $image, role: $role, totalEmployee: $totalEmployee, nameBrand: $nameBrand, startOperation: $startOperation, categoryBrand: $categoryBrand)';
  }

  factory User.initialUser() {
    return User(
      id: 0,
      name: '',
      email: '',
      password: '',
      phoneNumber: '',
      image: '',
      role: '',
      totalEmployee: 0,
      nameBrand: '',
      startOperation: '',
      categoryBrand: '',
    );
  }
}
