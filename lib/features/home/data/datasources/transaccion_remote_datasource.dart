
import 'package:tech_pay/features/home/data/models/transaccion_model.dart';

abstract class TransaccionRemoteDataSource {
  Future<List<TransaccionModel>> getTransacciones();
}