import 'package:tech_pay/features/home/domain/entities/apikey_entity.dart';
import 'package:tech_pay/features/home/domain/entities/cliente_entity.dart';
import 'package:tech_pay/features/home/domain/entities/transaccion_entity.dart';

class ClienteModel extends ClienteEntity {
  ClienteModel(
      {required super.clienteId,
      required super.clienteNombre,
      required super.apikeys,
      required super.transacciones});

    factory ClienteModel.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      print("❌ Error: Intentando convertir un JSON vacío en ClienteModel.");
      throw Exception("JSON vacío en ClienteModel.fromJson()");
    }

    return ClienteModel(
      clienteId: json["clienteId"] ?? "",
      clienteNombre: json["clienteNombre"] ?? "Sin Nombre",
      apikeys: (json["apikeys"] as List<dynamic>?)
              ?.map((x) => x != null ? ApikeyEntity.fromJson(x) : null)
              .whereType<ApikeyEntity>() // Filtra `null` en caso de que haya.
              .toList() ??
          [],
      transacciones: (json["transacciones"] as List<dynamic>?)
              ?.map((x) => x != null ? TransaccionEntity.fromJson(x) : null)
              .whereType<
                  TransaccionEntity>() // Filtra `null` en caso de que haya.
              .toList() ??
          [],
    );
  }


  Map<String, dynamic> toJson() => {
        "clienteId": clienteId,
        "clienteNombre": clienteNombre,
        "apikeys": apikeys.map((x) => x.toJson()).toList(),
        "transacciones": transacciones.map((x) => x.toJson()).toList(),
      };
}
