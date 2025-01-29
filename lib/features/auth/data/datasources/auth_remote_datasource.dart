import 'package:tech_pay/features/auth/domain/entities/usuario.dart';

import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<Usuario> login(String email, String password);
  Future<bool> isLoggedIn();
  Future<void> logout();

  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> deleteToken();

  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> deleteUser();
}

