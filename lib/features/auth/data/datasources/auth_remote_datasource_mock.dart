import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_pay/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:tech_pay/features/auth/data/models/user_model.dart';

class AuthRemoteDatasourceMock implements AuthRemoteDataSource {
  final FlutterSecureStorage storage;
  final SharedPreferences sharedPreferences;

  AuthRemoteDatasourceMock({required this.storage, required this.sharedPreferences});

  @override
  @override
  Future<UserModel> login(String email, String password) async {
     if (email == "adminPP@technova.com" && password == "password123") {
      final jsonResponse = {
        "code": 2,
        "usuario": {
          "usuario_id": 2,
          "usuario_nombre": "Admin",
          "usuario_correo": "adminPP@technova.com",
          "usuario_rol": {"rol_id": 1, "rol_nombre": "Administrador"}
        },
        "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
      };

      final userModel = UserModel.fromJson(jsonResponse);
      await saveToken(userModel.token);
      await saveUser(userModel);
      return userModel;

    } else {
      throw Exception("Credenciales incorrectas");
    }
  }

  
  @override
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
  
  @override
  Future<void> logout() async {
    await deleteToken();
    await deleteUser();
  }

  @override
  Future<void> saveToken(String token) async {
    await storage.write(key: 'pp-token', value: token);
  }

  @override
  Future<String?> getToken() async {
    return await storage.read(key: 'pp-token');
  }

  @override
  Future<void> deleteToken() async {
    await storage.delete(key: 'pp-token');
  }

  @override
  Future<void> saveUser(UserModel user) async {
    final userData = jsonEncode(user.toJson());
    await sharedPreferences.setString('user', userData);
  }

  @override
  Future<void> deleteUser() async {
    await sharedPreferences.remove('user');
  }

  @override
  Future<UserModel?> getUser() async {
    final userData = sharedPreferences.getString('user'); 
    if (userData == null) return null;

    try {
      final json = jsonDecode(userData); // Decodifica el JSON
      return UserModel.fromJson(json); // Convierte el JSON a UserModel
    } catch (e) {
      print('Error al procesar el JSON: $e');
      return null;
    }
  }
}