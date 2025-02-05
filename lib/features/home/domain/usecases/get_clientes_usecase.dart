
import 'package:tech_pay/features/home/domain/entities/cliente_entity.dart';
import 'package:tech_pay/features/home/domain/repositories/cliente_repository.dart';

class GetClientesUsecase {
  final ClienteRepository repository;

  GetClientesUsecase(this.repository);

  Future<List<ClienteEntity>> call() async {
    return await repository.getClientes();
  }
} 