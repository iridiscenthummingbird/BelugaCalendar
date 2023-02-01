import 'dart:convert' as dart_convert;

import 'package:equatable/equatable.dart';

String encodeUserToString(UserModel user) => dart_convert.json.encode(user.toJson());

class UserModel extends Equatable {
  const UserModel({
    required this.id,
    this.email,
    this.name,
    required this.isTermsAccepted,
    required this.phone,
  });

  final String id;
  final String? email;
  final String? name;
  final String phone;
  final bool isTermsAccepted;

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
      phone: phone ?? this.phone,
      isTermsAccepted: isTermsAccepted ?? this.isTermsAccepted,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) throw (Exception('user_from_json_error'));

    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      isTermsAccepted: json['is_terms_accepted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'is_terms_accepted': isTermsAccepted,
    };
  }

  @override
  List<Object?> get props => [id, email, name, isTermsAccepted, phone];
}
