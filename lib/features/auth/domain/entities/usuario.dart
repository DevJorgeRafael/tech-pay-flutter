class Usuario {
  final int usuarioId;
  final String usuarioNombre;
  final String usuarioCorreo;
  final UsuarioRol usuarioRol;

  Usuario({
    required this.usuarioId,
    required this.usuarioNombre,
    required this.usuarioCorreo,
    required this.usuarioRol,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        usuarioId: json["usuario_id"],
        usuarioNombre: json["usuario_nombre"],
        usuarioCorreo: json["usuario_correo"],
        usuarioRol: UsuarioRol.fromJson(json["usuario_rol"]),
      );

  Map<String, dynamic> toJson() => {
        "usuario_id": usuarioId,
        "usuario_nombre": usuarioNombre,
        "usuario_correo": usuarioCorreo,
        "usuario_rol": usuarioRol.toJson(),
      };
}

class UsuarioRol {
  final int rolId;
  final String rolNombre;

  UsuarioRol({
    required this.rolId,
    required this.rolNombre,
  });

  factory UsuarioRol.fromJson(Map<String, dynamic> json) => UsuarioRol(
        rolId: json["rol_id"],
        rolNombre: json["rol_nombre"],
      );

  Map<String, dynamic> toJson() => {
        "rol_id": rolId,
        "rol_nombre": rolNombre,
      };
}
