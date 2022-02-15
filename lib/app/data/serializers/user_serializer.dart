import 'dart:convert';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'package:list_of_products/app/core/table_keys.dart';
import 'package:list_of_products/app/domain/entities/user.dart';

class UserSerializer implements User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  UserSerializer({
    this.id = '',
    this.name,
    this.email,
    this.password,
    this.confirmPassword,
  });

  factory UserSerializer.mapParseToUser(ParseUser parseUser) {
    return UserSerializer(
      id: parseUser.objectId,
      name: parseUser.get(keyUserName),
      email: parseUser.get(keyUserEmail),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }

  factory UserSerializer.fromMap(Map<String, dynamic> map) {
    return UserSerializer(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      confirmPassword: map['confirmPassword'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserSerializer.fromJson(String source) =>
      UserSerializer.fromMap(json.decode(source));
}
