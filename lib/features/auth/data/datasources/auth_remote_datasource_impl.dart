import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_pay/shared/services/dio_client.dart';
import '../models/user_model.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio = DioClient.instance;
  final FlutterSecureStorage storage;
  final SharedPreferences sharedPreferences;

  AuthRemoteDataSourceImpl({required this.storage, required this.sharedPreferences});

  @override
  Future<UserModel> login(String email, String password) async {
    print('🌍 ENV: -------------> ${dio.options.baseUrl}');

    try {
      final response = await dio.post('/auth/login', data: {
        'correo': email,
        'password': password,
      });

      print('✅ Respuesta del servidor: ${response.data}');

      if (response.statusCode == 201) {
        // 🔥 Asegurar que la respuesta es un Map<String, dynamic>
        if (response.data is Map<String, dynamic>) {
          return UserModel.fromJson(
              response.data); // ✅ Devuelve UserModel correctamente
        } else {
          print('⚠️ Error: La respuesta del servidor no es un JSON válido');
          throw AuthException('Error inesperado en la autenticación.');
        }
      } else {
        throw AuthException('Error desconocido en la autenticación.');
      }
    } catch (e) {
      if (e is DioException) {
        final statusCode = e.response?.statusCode;
        final responseData = e.response?.data;

        if (statusCode == 401 && responseData is Map<String, dynamic>) {
          if (responseData['code'] == 1) {
            throw AuthException(
                '❌ Credenciales inválidas. Verifica tu correo y contraseña.');
          }
        }
        throw AuthException('⚠️ Error al iniciar sesión: ${e.message}');
      } else {
        print('🔥 Error desconocido: $e');
        throw AuthException('⚠️ Error inesperado al conectar con el servidor.');
      }
    }
  }




  @override
  Future<void> logout() async {
    try {
      await dio.post('/auth/logout');
    } catch (e) {
      throw Exception('Error al cerrar sesión: $e');
    }
  }
  
  @override
  Future<bool> isLoggedIn() async {
    try {
      final response = await dio.get('/auth/validate-token');
      return response.statusCode == 200;
    } catch (e) {
      return false; // Si no se puede validar, asumimos que el token no es válido
    }
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
    if(userData == null) return null;
    return UserModel.fromJson(jsonDecode(userData));
  }
}

// Nueva Clase de Excepción
class AuthException implements Exception {
  final String message;
  AuthException(this.message);
  @override
  String toString() => message; // Evita que se muestre "Exception: ..."
}
