
import 'package:tech_pay/features/home/domain/repositories/cliente_repository.dart';

class UpdateClienteUsecase {
  final ClienteRepository repository; 

  UpdateClienteUsecase(this.repository);

  Future<void> call(int id, String clienteNombre) async {
    await repository.updateCliente(id, clienteNombre);
  }
}