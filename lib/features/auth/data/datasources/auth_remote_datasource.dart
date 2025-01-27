import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<bool> isLoggedIn();
  Future<void> logout();
}

