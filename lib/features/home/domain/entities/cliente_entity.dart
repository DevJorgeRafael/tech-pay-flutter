import 'package:tech_pay/features/home/domain/entities/apikey_entity.dart';
import 'package:tech_pay/features/home/domain/entities/transaccion_entity.dart';

class ClienteEntity {
  final String clienteId;
  final String clienteNombre;
  final List<ApikeyEntity> apikeys;
  final List<TransaccionEntity> transacciones;

  ClienteEntity({
    required this.clienteId,
    required this.clienteNombre,
    required this.apikeys,
    required this.transacciones,
  });

  factory ClienteEntity.fromJson(Map<String, dynamic> json) => ClienteEntity(
        clienteId: json["clienteId"],
        clienteNombre: json["clienteNombre"],
        apikeys: (json["apikeys"] as List<dynamic>?)
                ?.map((x) => ApikeyEntity.fromJson(x))
                .toList() ??
            [],
        transacciones: (json["transacciones"] as List<dynamic>?)
                ?.map((x) => TransaccionEntity.fromJson(x))
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        "clienteId": clienteId,
        "clienteNombre": clienteNombre,
        "apikeys": apikeys.map((x) => x.toJson()).toList(),
        "transacciones": transacciones.map((x) => x.toJson()).toList(),
      };
}
