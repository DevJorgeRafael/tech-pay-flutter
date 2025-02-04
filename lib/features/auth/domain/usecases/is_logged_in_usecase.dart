import 'package:tech_pay/features/auth/domain/repositories/auth_repository.dart';

class IsLoggedInUseCase {
  final AuthRepository repository;

  IsLoggedInUseCase(this.repository);

  Future<bool> call() async {
    final token = await repository.getToken();
    if (token == null || token.isEmpty) return false;

    return await repository.validateToken(token);
  }
}