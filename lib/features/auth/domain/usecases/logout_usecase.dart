import 'package:tech_pay/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<void> call() async {
    return await repository.logout();
  }
}