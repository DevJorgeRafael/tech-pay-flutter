import 'dart:convert';

import 'package:tech_pay/features/home/domain/entities/cliente_entity.dart';
import 'package:tech_pay/features/home/domain/entities/estado_transaccion_entity.dart';

List<TransaccionModel> transaccionModelFromJson(String str) =>
    List<TransaccionModel>.from(
        json.decode(str).map((x) => TransaccionModel.fromJson(x)));

String transaccionModelToJson(List<TransaccionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransaccionModel {
  final String transaccionId;
  final String transaccionMonto;
  final DateTime transaccionFecha;
  final String transaccionMoneda;
  final String transaccionDescripcion;
  final EstadoTransaccionEntity estadoTransaccion;
  final Cliente cliente;

  TransaccionModel({
    required this.transaccionId,
    required this.transaccionMonto,
    required this.transaccionFecha,
    required this.transaccionMoneda,
    required this.transaccionDescripcion,
    required this.estadoTransaccion,
    required this.cliente,
  });

  factory TransaccionModel.fromJson(Map<String, dynamic> json) =>
      TransaccionModel(
        transaccionId: json["transaccionId"],
        transaccionMonto: json["transaccionMonto"],
        transaccionFecha: DateTime.parse(json["transaccionFecha"]),
        transaccionMoneda: json["transaccionMoneda"],
        transaccionDescripcion: json["transaccionDescripcion"],
        estadoTransaccion: EstadoTransaccionEntity.fromJson(json["estadotransaccion"]),
        cliente: Cliente.fromJson(json["cliente"]),
      );

  Map<String, dynamic> toJson() => {
        "transaccionId": transaccionId,
        "transaccionMonto": transaccionMonto,
        "transaccionFecha": transaccionFecha.toIso8601String(),
        "transaccionMoneda": transaccionMoneda,
        "transaccionDescripcion": transaccionDescripcion,
        "estadotransaccion": estadoTransaccion.toJson(),
        "cliente": cliente.toJson(),
      };
}
