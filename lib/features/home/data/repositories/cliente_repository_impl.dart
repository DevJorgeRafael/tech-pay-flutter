
import 'package:tech_pay/features/home/data/datasources/cliente_remote_datasource.dart';
import 'package:tech_pay/features/home/domain/entities/cliente_entity.dart';
import 'package:tech_pay/features/home/domain/repositories/cliente_repository.dart';

class ClienteRepositoryImpl implements ClienteRepository {
  final ClienteRemoteDataSource remoteDataSource;

  ClienteRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> addCliente(String clienteNombre) async {
    await remoteDataSource.addCliente(clienteNombre);
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

}