import 'package:tech_pay/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<bool> isLoggedIn();
  Future<void> logout();
}