

import 'package:dio/dio.dart';
import 'package:tech_pay/features/home/data/datasources/transaccion_remote_datasource.dart';
import 'package:tech_pay/features/home/data/models/transaccion_model.dart';
import 'package:tech_pay/shared/services/dio_client.dart';

class TransaccionRemoteDatasourceImpl implements TransaccionRemoteDataSource{
  final Dio dio = DioClient.instance;

  @override
  Future<List<TransaccionModel>> getTransacciones() async {
    try {
      final response = await dio.get('/transacciones');

      if (response.statusCode == 200) {
        return List<TransaccionModel>.from(
          response.data.map((x) => TransaccionModel.fromJson(x))
        );
      } else {
        throw Exception('Error al obtener las transacciones');
      }
    } catch (e) {
      print('❌ Error al obtener transacciones: $e');
      throw Exception('Error de conexión con el servidor');
    }
  }

}