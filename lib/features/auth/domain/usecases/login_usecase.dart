import '../repositories/auth_repository.dart';
import '../entities/usuario.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Usuario> call(String email, String password) async {
    // Llama al repositorio y obtiene un UserModel
    final userModel = await repository.login(email, password);

    // Convierte el UserModel a una entidad User (si es necesario)
    return Usuario(
      usuarioId: userModel.usuarioId,
      usuarioNombre: userModel.usuarioNombre,
      usuarioCorreo: userModel.usuarioCorreo,
      usuarioRol: userModel.usuarioRol,
    );
  }
}
