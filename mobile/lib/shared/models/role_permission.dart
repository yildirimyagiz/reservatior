import 'permission.dart';
import 'role.dart';

class RolePermission {
  final String id;
  final String roleId;
  final String permissionId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Role role;
  final Permission permission;

  const RolePermission({
    required this.id,
    required this.roleId,
    required this.permissionId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.role,
    required this.permission,
  });

  factory RolePermission.fromJson(Map<String, dynamic> json) {
    return RolePermission(
      id: json['id'] as String,
      roleId: json['roleId'] as String,
      permissionId: json['permissionId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      role: Role.fromJson(json['role'] as Map<String, dynamic>),
      permission: Permission.fromJson(json['permission'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roleId': roleId,
      'permissionId': permissionId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'role': role.toJson(),
      'permission': permission.toJson(),
    };
  }

  RolePermission copyWith({
    String? id,
    String? roleId,
    String? permissionId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Role? role,
    Permission? permission,
  }) {
    return RolePermission(
      id: id ?? this.id,
      roleId: roleId ?? this.roleId,
      permissionId: permissionId ?? this.permissionId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      role: role ?? this.role,
      permission: permission ?? this.permission,
    );
  }
}
