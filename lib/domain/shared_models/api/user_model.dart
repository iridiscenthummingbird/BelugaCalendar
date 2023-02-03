import 'dart:convert' as dart_convert;

import 'package:equatable/equatable.dart';

String encodeUserToString(UserModel user) =>
    dart_convert.json.encode(user.toJson());

class UserModel extends Equatable {
  const UserModel({
    required this.id,
    this.name,
    required this.email,
  });

  final String id;
  final String? email;
  final String? name;

  @override
  String toString() {
    return 'User: { '
        'id: $id, '
        'email: $email, '
        '}';
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? phone,
    bool? isTermsAccepted,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) throw (Exception('user_from_json_error'));

    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [id, email, name];
}
