import '../repositories/auth_repository.dart';
import '../entities/usuario_entity.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<UserEntity> call(String email, String password) async {
    // Llama al repositorio y obtiene un UserModel
    final userModel = await repository.login(email, password);

    // Convierte el UserModel a una entidad User (si es necesario)
    return UserEntity(
      userId: userModel.userId,
      usuarioNombre: userModel.usuarioNombre,
      userEmail: userModel.userEmail,
      userRole: userModel.userRole,
    );
  }
}
