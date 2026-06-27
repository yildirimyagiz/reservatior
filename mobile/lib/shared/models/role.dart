import 'package:reservatior/shared/enums/member_role_key.dart';
import 'organization.dart';
import 'role_permission.dart';

class Role {
  final String id;
  final String orgId;
  final MemberRoleKey key;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String? locationId;
  final Organization org;
  final List<RolePermission> permissions;

  const Role({
    required this.id,
    required this.orgId,
    required this.key,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.locationId,
    required this.org,
    this.permissions = const [],
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      key: MemberRoleKey.values.firstWhere((v) => v.name == json['key']),
      name: json['name'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      locationId: json['locationId'] as String?,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      permissions: (json['permissions'] as List<dynamic>?)?.map((e) => RolePermission.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'key': key.name,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'locationId': locationId,
      'org': org.toJson(),
      'permissions': permissions.map((e) => e.toJson()).toList(),
    };
  }

  Role copyWith({
    String? id,
    String? orgId,
    MemberRoleKey? key,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    String? locationId,
    Organization? org,
    List<RolePermission>? permissions,
  }) {
    return Role(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      key: key ?? this.key,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      locationId: locationId ?? this.locationId,
      org: org ?? this.org,
      permissions: permissions ?? this.permissions,
    );
  }
}
