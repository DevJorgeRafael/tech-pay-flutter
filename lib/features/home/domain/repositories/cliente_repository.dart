
import 'package:tech_pay/features/home/domain/entities/apikey_entity.dart';
import 'package:tech_pay/features/home/domain/entities/cliente_entity.dart';

abstract class ClienteRepository {
  Future<List<ClienteEntity>> getClientes();
  Future<ClienteEntity> getCliente(int id);
  Future<ClienteEntity> addCliente(String clienteNombre);
  Future<void> updateCliente(int id, String clienteNombre);
  Future<void> updateApikeyEstado(String apikeyId, bool nuevoEstado);
  Future<ApikeyEntity> addApikey(String clienteId, String descripcion); 
}