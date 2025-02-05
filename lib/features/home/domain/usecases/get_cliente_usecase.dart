
import 'package:tech_pay/features/home/domain/entities/cliente_entity.dart';
import 'package:tech_pay/features/home/domain/repositories/cliente_repository.dart';

class GetClienteUsecase {
  final ClienteRepository repository;

  GetClienteUsecase(this.repository);

  Future<ClienteEntity> call(int id) async {
    return await repository.getCliente(id);
  }
}