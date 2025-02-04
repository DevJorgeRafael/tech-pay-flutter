import 'package:tech_pay/features/auth/data/models/user_model.dart';
import 'package:tech_pay/features/auth/domain/entities/usuario_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<bool> isLoggedIn();
  Future<void> logout();
  Future<UserEntity?> getStoredUser();
  Future<bool> validateToken(String token);
  Future<String?> getToken();
  Future<void> deleteStoredUser();
  Future<void> deleteToken();
  Future<void> saveUser(UserModel userModel);
}