import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? password;
  final String? role;

  const User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.role,
  });

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, password: $password, role: $role)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      email,
      password,
      role,
    ];
  }

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? password,
    String? role,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (password != null) {
      result.addAll({'password': password});
    }
    if (role != null) {
      result.addAll({'role': role});
    }

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt(),
      name: map['name'],
      email: map['email'],
      password: map['password'],
      role: map['role'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
