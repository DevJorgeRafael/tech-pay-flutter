import 'package:tech_pay/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:tech_pay/features/auth/data/models/user_model.dart';

class AuthRemoteDatasourceMock implements AuthRemoteDataSource {
  bool _isLoggedIn = true;

  @override
  Future<UserModel> login(String email, String password) async {
    // Simulamos un retraso como si fuera una API real
    await Future.delayed(const Duration(seconds: 2));

    // Retornamos datos simulados
    return UserModel(
      id: '123',
      name: 'Mock User',
      email: email,
    );
  }
  
  @override
  Future<bool> isLoggedIn() async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
  
  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(seconds: 1));
    _isLoggedIn = false;
  }
}