class UserEntity {
  final int userId;
  final String usuarioNombre;
  final String userEmail;
  final UserRole userRole;

  UserEntity({
    required this.userId,
    required this.usuarioNombre,
    required this.userEmail,
    required this.userRole,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        userId: json["usuario_id"],
        usuarioNombre: json["usuario_nombre"],
        userEmail: json["usuario_correo"],
        userRole: UserRole.fromJson(json["usuario_rol"]),
      );

  Map<String, dynamic> toJson() => {
        "usuario_id": userId,
        "usuario_nombre": usuarioNombre,
        "usuario_correo": userEmail,
        "usuario_rol": userRole.toJson(),
      };
}

class UserRole {
  final int roleId;
  final String roleName;

  UserRole({
    required this.roleId,
    required this.roleName,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) => UserRole(
        roleId: json["rol_id"],
        roleName: json["rol_nombre"],
      );

  Map<String, dynamic> toJson() => {
        "rol_id": roleId,
        "rol_nombre": roleName,
      };
}
