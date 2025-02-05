

import 'package:dio/dio.dart';
import 'package:tech_pay/features/home/data/datasources/cliente_remote_datasource.dart';
import 'package:tech_pay/features/home/data/models/cliente_model.dart';
import 'package:tech_pay/features/home/domain/entities/apikey_entity.dart';
import 'package:tech_pay/shared/services/dio_client.dart';

class ClienteRemoteDatasourceImpl implements ClienteRemoteDataSource{
  final Dio dio = DioClient.instance;
  
  @override
  Future<List<ClienteModel>> getClientes() async {
    try {
      final response = await dio.get('/clientes');
      return List<ClienteModel>.from(response.data.map((x) => ClienteModel.fromJson(x)));
    } catch (e) {
      throw Exception('Error al obtener clientes: $e');
    }
  }

  @override
  Future<ClienteModel> getCliente(int id) async {
    try {
      final response = await dio.get('/clientes/$id');
      return ClienteModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Error al obtener cliente');
    }
  }

  @override
  Future<void> addCliente(String clienteNombre) async {
    try {
      await dio.post('/clientes', data: {
        'clienteNombre': clienteNombre
      });
    } catch (e) {
      print('❌ Error al agregar cliente: $e');
    }
  }

  @override
  Future<void> updateCliente(int id, String clienteNombre) async {
    try {
      await dio.put('/clientes/$id', data: {
        'clienteNombre': clienteNombre
      });
    } catch (e) {
      print('❌ Error al actualizar cliente: $e');
    }
  }

  @override
  Future<ApikeyEntity> addApikey(String clienteId, String descripcion) async {
    try {
      final response = await dio.post('/apikeys', data: {
        'cliente_id': clienteId,
        'apikey_descripcion': descripcion
      });

      return ApikeyEntity.fromJson(response.data);
    } catch (e) {
      print('❌ Error al agregar apikey: $e');
      throw Exception('Error al agregar apikey: $e');
    }
  }

  @override
  Future<void> updateApikeyEstado(String apikeyId, bool nuevoEstado) async {
    try {
      await dio.put('/apikeys/$apikeyId', data: {
        'apikey_estado': nuevoEstado
      });
    } catch (e) {
      print('❌ Error al actualizar estado de apikey: $e');
      throw Exception('Error al actualizar estado de apikey: $e');
    }
  }

}