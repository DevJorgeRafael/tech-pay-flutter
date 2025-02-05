
import 'package:tech_pay/features/home/domain/entities/cliente_entity.dart';

abstract class ClienteRepository {
  Future<List<ClienteEntity>> getClientes();
  Future<ClienteEntity> getCliente(int id);
  Future<void> addCliente(String clienteNombre);
  Future<void> updateCliente(int id, String clienteNombre);

}