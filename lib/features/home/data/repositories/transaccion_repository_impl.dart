

import 'package:tech_pay/features/home/data/datasources/transaccion_remote_datasource.dart';
import 'package:tech_pay/features/home/domain/entities/transaccion_entity.dart';
import 'package:tech_pay/features/home/domain/repositories/transaccion_repository.dart';

class TransaccionRepositoryImpl  implements TransaccionRepository {
  final TransaccionRemoteDataSource remoteDataSource;

  TransaccionRepositoryImpl({required this.remoteDataSource});
  
  @override
  Future<List<TransaccionEntity>> getTransacciones() async {
    final transaccionesModel = await remoteDataSource.getTransacciones();

    return transaccionesModel.map((model) => TransaccionEntity(
      transaccionId: model.transaccionId, 
      transaccionMonto: model.transaccionMonto, 
      transaccionFecha: model.transaccionFecha, 
      transaccionMoneda: model.transaccionMoneda, 
      transaccionDescripcion: model.transaccionDescripcion, 
      estadoTransaccion: model.estadoTransaccion, 
      cliente: model.cliente
    )).toList();
  }

}