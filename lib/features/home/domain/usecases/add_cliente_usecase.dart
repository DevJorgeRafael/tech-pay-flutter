
import 'package:tech_pay/features/home/domain/repositories/cliente_repository.dart';

class AddClienteUsecase {
  final ClienteRepository repository;

  AddClienteUsecase(this.repository);

  Future<void> call(String clienteNombre) async {
    return await repository.addCliente(clienteNombre);
  }
} 