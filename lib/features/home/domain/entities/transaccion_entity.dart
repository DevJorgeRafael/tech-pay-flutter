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

  factory TransaccionEntity.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      print("❌ Error: JSON vacío en TransaccionEntity.");
      throw Exception("JSON vacío en TransaccionEntity.fromJson()");
    }

    return TransaccionEntity(
      transaccionId: json["transaccionId"] ?? "",
      transaccionMonto: json["transaccionMonto"] ?? "0.00",
      transaccionFecha: json["transaccionFecha"] != null
          ? DateTime.parse(json["transaccionFecha"])
          : DateTime.now(),
      transaccionMoneda: json["transaccionMoneda"] ?? "USD",
      transaccionDescripcion:
          json["transaccionDescripcion"] ?? "Sin descripción",
      estadoTransaccion: json["estadoTransaccion"] != null
          ? EstadoTransaccionEntity.fromJson(json["estadoTransaccion"])
          : EstadoTransaccionEntity(
              estadoId: "0", // Se agrega un valor por defecto para estadoId
              estadoNombre: "Desconocido",
            ),
      cliente: json["cliente"] != null
          ? ClienteEntity.fromJson(json["cliente"])
          : ClienteEntity(
              clienteId: "", clienteNombre: "", apikeys: [], transacciones: []),
    );
  }


  Map<String, dynamic> toJson() => {
        "transaccionId": transaccionId,
        "transaccionMonto": transaccionMonto,
        "transaccionFecha": transaccionFecha.toIso8601String(),
        "transaccionMoneda": transaccionMoneda,
        "transaccionDescripcion": transaccionDescripcion,
        "estadoTransaccion": estadoTransaccion.toJson(),
        "cliente": cliente.toJson(),
      };
}
