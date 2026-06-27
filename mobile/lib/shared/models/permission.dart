import 'package:reservatior/shared/enums/permission_key.dart';
import 'role_permission.dart';

class Permission {
  final String id;
  final PermissionKey key;
  final String name;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<RolePermission> roles;

  const Permission({
    required this.id,
    required this.key,
    required this.name,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.roles = const [],
  });

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      id: json['id'] as String,
      key: PermissionKey.values.firstWhere((v) => v.name == json['key']),
      name: json['name'] as String,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      roles: (json['roles'] as List<dynamic>?)?.map((e) => RolePermission.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'key': key.name,
      'name': name,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'roles': roles.map((e) => e.toJson()).toList(),
    };
  }

  Permission copyWith({
    String? id,
    PermissionKey? key,
    String? name,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    List<RolePermission>? roles,
  }) {
    return Permission(
      id: id ?? this.id,
      key: key ?? this.key,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      roles: roles ?? this.roles,
    );
  }
}
