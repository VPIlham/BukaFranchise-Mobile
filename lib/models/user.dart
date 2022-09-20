import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? password;
  final String? role;
  final int? totalEmployee;
  final String? nameBrand;
  final String? startOperation;
  final String? categoryBrand;

  static var empty;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
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
      role: role ?? this.role,
      totalEmployee: totalEmployee ?? this.totalEmployee,
      nameBrand: nameBrand ?? this.nameBrand,
      startOperation: startOperation ?? this.startOperation,
      categoryBrand: categoryBrand ?? this.categoryBrand,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, password: $password, role: $role, totalEmployee: $totalEmployee, nameBrand: $nameBrand, startOperation: $startOperation, categoryBrand: $categoryBrand)';
  }
}
