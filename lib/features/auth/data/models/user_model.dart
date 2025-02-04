import 'dart:convert';

import 'package:tech_pay/features/auth/domain/entities/usuario_entity.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final int code;
  final UserEntity user;
  final String token;

  UserModel({
    required this.code,
    required this.user,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        code: json["code"],
        user: UserEntity.fromJson(json["usuario"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "usuario": user.toJson(),
        "token": token,
      };
}
