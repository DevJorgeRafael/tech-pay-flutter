
import 'package:tech_pay/features/home/data/datasources/cliente_remote_datasource.dart';
import 'package:tech_pay/features/home/domain/entities/apikey_entity.dart';
import 'package:tech_pay/features/home/domain/entities/cliente_entity.dart';
import 'package:tech_pay/features/home/domain/repositories/cliente_repository.dart';

class ClienteRepositoryImpl implements ClienteRepository {
  final ClienteRemoteDataSource remoteDataSource;

  ClienteRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ClienteEntity> addCliente(String clienteNombre) async {
    return await remoteDataSource.addCliente(clienteNombre);
  }

  @override
  Future<ClienteEntity> getCliente(int id) async {
    return await remoteDataSource.getCliente(id);
  }

  @override
  Future<List<ClienteEntity>> getClientes() async {
    return await remoteDataSource.getClientes();
  }

  @override
  Future<void> updateCliente(int id, String clienteNombre) async {
    return await remoteDataSource.updateCliente(id, clienteNombre);
  }

  @override
  Future<ApikeyEntity> addApikey(String clienteId, String descripcion) async {
    return await remoteDataSource.addApikey(clienteId, descripcion);
  }

  @override
  Future<void> updateApikeyEstado(String apikeyId, bool nuevoEstado) async {
    return await remoteDataSource.updateApikeyEstado(apikeyId, nuevoEstado);
  }

}