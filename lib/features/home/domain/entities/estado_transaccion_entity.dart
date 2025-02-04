class EstadoTransaccionEntity {
  final String estadoId;
  final String estadoNombre;

  EstadoTransaccionEntity({
    required this.estadoId,
    required this.estadoNombre,
  });

  factory EstadoTransaccionEntity.fromJson(Map<String, dynamic> json) =>
      EstadoTransaccionEntity(
        estadoId: json["estadotrId"],
        estadoNombre: json["estadotrNombre"],
      );

  Map<String, dynamic> toJson() => {
        "estadotrId": estadoId,
        "estadotrNombre": estadoNombre,
      };
}