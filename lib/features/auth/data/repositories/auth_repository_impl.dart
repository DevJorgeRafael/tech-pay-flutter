import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_pay/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:tech_pay/features/auth/domain/entities/usuario_entity.dart';
import 'package:tech_pay/features/auth/domain/repositories/auth_repository.dart';
import 'package:tech_pay/features/auth/data/models/user_model.dart';
import 'package:tech_pay/shared/services/auth_token_service.dart';
import 'package:tech_pay/shared/services/dio_client.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> login(String email, String password) async {
    final UserModel userModel = await remoteDataSource.login(email, password);

    print('🟢 Guardando token después del login: ${userModel.token}');
    await AuthTokenService.saveToken(
        userModel.token); // ✅ Guarda el token de manera segura

    print('🟢 Guardando usuario en SharedPreferences...');
    await saveUser(userModel); // ✅ Guarda el usuario correctamente

    return userModel.user; // ✅ Retorna solo el `UserEntity`
  }

  @override
  Future<void> saveUser(UserModel userModel) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(userModel.toJson());

    print('🟢 Guardando usuario en SharedPreferences: $userJson');

    await prefs.setString('user', userJson);
  }

  @override
  Future<UserEntity?> getStoredUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');

    if (userJson == null) {
      print('🔴 No hay usuario almacenado en SharedPreferences.');
      return null;
    }

    print('🔵 Usuario recuperado de SharedPreferences: $userJson');

    return UserModel.fromJson(jsonDecode(userJson))
        .user; // ✅ Retorna `UserEntity`
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    if (token == null || token.isEmpty) return false;

    return await validateToken(token);
  }

  @override
  Future<bool> validateToken(String token) async {
    try {
      print('🟡 Validando token: $token');
      final response = await DioClient.instance.get(
        '/auth/validate-token',
        options: Options(headers: {'pp-token': token}),
      );

      print('🟢 Respuesta del backend: ${response.data}');
      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return response.data['valid'] == true;
      }
      return false;
    } catch (e) {
      print('🔴 Error validando token: $e');
      return false;
    }
  }

  @override
  Future<String?> getToken() async {
    final token = await AuthTokenService.getToken();
    print('🔵 Token obtenido de almacenamiento: $token');
    return token;
  }

  @override
  Future<void> deleteStoredUser() async {
    final prefs = await SharedPreferences.getInstance();
    print('🛑 Eliminando usuario de SharedPreferences...');
    await prefs.remove('user');
  }

  @override
  Future<void> deleteToken() async {
    print('🛑 Eliminando token...');
    await AuthTokenService.deleteToken();
    print('✅ Token eliminado.');
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
    await deleteStoredUser();
    await deleteToken();
  }
}
