import 'package:tech_pay/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:tech_pay/features/auth/domain/entities/usuario.dart';
import 'package:tech_pay/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Usuario> login(String email, String password) async {
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

  @override
  Future<Usuario?> getStoredUser() async {
    final userModel = await remoteDataSource.getUser();
    print('Usuario almacenado desde auth_repository ---------> $userModel');
    if (userModel != null) {
      return Usuario(
        usuarioId: userModel.usuario.usuarioId,
        usuarioNombre: userModel.usuario.usuarioNombre,
        usuarioCorreo: userModel.usuario.usuarioCorreo,
        usuarioRol: userModel.usuario.usuarioRol,
      );
    }
    return null;
  }

}