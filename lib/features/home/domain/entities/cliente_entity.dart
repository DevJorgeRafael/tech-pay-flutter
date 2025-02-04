class Cliente {
  final String clienteId;
  final String clienteNombre; 

  Cliente({
    required this.clienteId,
    required this.clienteNombre,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        clienteId: json["clienteId"],
        clienteNombre: json["clienteNombre"], 
      );

  Map<String, dynamic> toJson() => {
        "clienteId": clienteId,
        "clienteNombre": clienteNombre, 
      };
}
