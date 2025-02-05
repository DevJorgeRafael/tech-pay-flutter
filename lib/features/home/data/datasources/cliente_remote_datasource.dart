
import 'package:tech_pay/features/home/data/models/cliente_model.dart';
import 'package:tech_pay/features/home/domain/entities/apikey_entity.dart';

abstract class ClienteRemoteDataSource {
  Future<List<ClienteModel>> getClientes();
  Future<ClienteModel> getCliente(int id);
  Future<ClienteModel> addCliente(String clienteNombre);
  Future<void> updateCliente(int id, String clienteNombre);
  Future<void> updateApikeyEstado(String apikeyId, bool nuevoEstado);
  Future<ApikeyEntity> addApikey(String clienteId, String descripcion);
}