import 'dart:convert';

import 'package:tech_pay/features/auth/domain/entities/usuario.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final int code;
  final Usuario usuario;
  final String token;

  UserModel({
    required this.code,
    required this.usuario,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        code: json["code"],
        usuario: Usuario.fromJson(json["usuario"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "usuario": usuario.toJson(),
        "token": token,
      };
}
