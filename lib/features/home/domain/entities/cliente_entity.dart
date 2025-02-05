class ClienteEntity {
  final String clienteId;
  final String clienteNombre; 

  ClienteEntity({
    required this.clienteId,
    required this.clienteNombre,
  });

  factory ClienteEntity.fromJson(Map<String, dynamic> json) => ClienteEntity(
        clienteId: json["clienteId"],
        clienteNombre: json["clienteNombre"], 
      );

  Map<String, dynamic> toJson() => {
        "clienteId": clienteId,
        "clienteNombre": clienteNombre, 
      };
}
