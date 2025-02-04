import 'package:tech_pay/features/home/domain/entities/transaccion_entity.dart';

abstract class TransaccionRepository {
  Future<List<TransaccionEntity>> getTransacciones();
}