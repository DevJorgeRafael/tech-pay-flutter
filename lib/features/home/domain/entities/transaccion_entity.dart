
import 'package:tech_pay/features/home/domain/entities/cliente_entity.dart';
import 'package:tech_pay/features/home/domain/entities/estado_transaccion_entity.dart';

class TransaccionEntity {
  final String transaccionId;
  final String transaccionMonto;
  final DateTime transaccionFecha;
  final String transaccionMoneda;
  final String transaccionDescripcion;
  final EstadoTransaccionEntity estadoTransaccion;
  final ClienteEntity cliente;

  TransaccionEntity({
    required this.transaccionId,
    required this.transaccionMonto,
    required this.transaccionFecha,
    required this.transaccionMoneda,
    required this.transaccionDescripcion,
    required this.estadoTransaccion,
    required this.cliente,
  });
}