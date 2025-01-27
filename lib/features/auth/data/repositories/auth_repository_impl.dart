import 'package:tech_pay/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:tech_pay/features/auth/domain/entities/user.dart';
import 'package:tech_pay/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<User> login(String email, String password) async {
    final userModel = await remoteDataSource.login(email, password);
    return userModel;
  }

  @override
  Future<bool> isLoggedIn() async {
    return await remoteDataSource.isLoggedIn();
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
  }

}