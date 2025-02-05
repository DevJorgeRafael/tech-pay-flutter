class ApikeyEntity {
  final String apikeyId;
  final String apikeyKey;
  final String apikeyDescripcion;
  final bool apikeyEstado;

  ApikeyEntity({
    required this.apikeyId,
    required this.apikeyKey,
    required this.apikeyDescripcion,
    required this.apikeyEstado,
  });

  factory ApikeyEntity.fromJson(Map<String, dynamic> json) => ApikeyEntity(
        apikeyId: json["apikeyId"] ?? '',
        apikeyKey: json["apikeyKey"] ?? '',
        apikeyDescripcion: json["apikeyDescripcion"] ?? '',
        apikeyEstado: json["apikeyEstado"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "apikeyId": apikeyId,
        "apikeyKey": apikeyKey,
        "apikeyDescripcion": apikeyDescripcion,
        "apikeyEstado": apikeyEstado,
      };
}
