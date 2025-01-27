import 'package:dio/dio.dart';
import '../models/user_model.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Error al iniciar sesión: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error al conectar con el servidor: $e');
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
}
