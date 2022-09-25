import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? password;
  final String? phoneNumber;
  final String? image;
  final String? norek;
  final String? bank;
  final String? role;
  final int? totalEmployee;
  final int? balance;
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
    this.norek,
    this.bank,
    this.role,
    this.totalEmployee,
    this.balance,
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
      norek,
      bank,
      role,
      totalEmployee,
      balance,
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
    String? norek,
    String? bank,
    String? role,
    int? totalEmployee,
    int? balance,
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
      norek: norek ?? this.norek,
      bank: bank ?? this.bank,
      role: role ?? this.role,
      totalEmployee: totalEmployee ?? this.totalEmployee,
      balance: balance ?? this.balance,
      nameBrand: nameBrand ?? this.nameBrand,
      startOperation: startOperation ?? this.startOperation,
      categoryBrand: categoryBrand ?? this.categoryBrand,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, password: $password, phoneNumber: $phoneNumber, image: $image, norek: $norek, bank: $bank, role: $role, totalEmployee: $totalEmployee, balance: $balance, nameBrand: $nameBrand, startOperation: $startOperation, categoryBrand: $categoryBrand)';
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
      norek: '',
      bank: '',
      balance: 0,
    );
  }
}
