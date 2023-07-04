import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? id;
  String name;
  String email;
  String phone;
  String role;
  String poli;
  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.poli,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'poli': poli,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['uid'],
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      role: map['role'] ?? '',
      poli: map['poli'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  static UserModel? fromFirebaseUser(User user) {}
}
