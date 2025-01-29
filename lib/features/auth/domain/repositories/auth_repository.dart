import 'package:tech_pay/features/auth/domain/entities/usuario.dart';

abstract class AuthRepository {
  Future<Usuario> login(String email, String password);
  Future<bool> isLoggedIn();
  Future<void> logout();
  Future<Usuario?> getStoredUser();
}