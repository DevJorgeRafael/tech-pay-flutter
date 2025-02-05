
import 'package:tech_pay/features/home/domain/entities/cliente_entity.dart';

class ClienteModel extends ClienteEntity{
  ClienteModel({
    required super.clienteId, 
    required super.clienteNombre
  });

  factory ClienteModel.fromJson(Map<String, dynamic> json) => ClienteModel(
    clienteId: json["clienteId"],
    clienteNombre: json["clienteNombre"]
  );

  Map<String, dynamic> toJson() => {
    "clienteId": clienteId,
    "clienteNombre": clienteNombre
  };

}