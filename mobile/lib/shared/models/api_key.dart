import 'organization.dart';
import 'user.dart';

class ApiKey {
  final String id;
  final String userId;
  final String? orgId;
  final String name;
  final String keyHash;
  final List<String> scopes;
  final DateTime? lastUsedAt;
  final DateTime? expiresAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Organization? org;
  final User user;

  const ApiKey({
    required this.id,
    required this.userId,
    this.orgId,
    required this.name,
    required this.keyHash,
    this.scopes = const [],
    this.lastUsedAt,
    this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.org,
    required this.user,
  });

  factory ApiKey.fromJson(Map<String, dynamic> json) {
    return ApiKey(
      id: json['id'] as String,
      userId: json['userId'] as String,
      orgId: json['orgId'] as String?,
      name: json['name'] as String,
      keyHash: json['keyHash'] as String,
      scopes: (json['scopes'] as List<dynamic>?)?.cast<String>() ?? [],
      lastUsedAt: json['lastUsedAt'] != null ? DateTime.parse(json['lastUsedAt'] as String) : null,
      expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt'] as String) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'orgId': orgId,
      'name': name,
      'keyHash': keyHash,
      'scopes': scopes,
      'lastUsedAt': lastUsedAt?.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'org': org?.toJson(),
      'user': user.toJson(),
    };
  }

  ApiKey copyWith({
    String? id,
    String? userId,
    String? orgId,
    String? name,
    String? keyHash,
    List<String>? scopes,
    DateTime? lastUsedAt,
    DateTime? expiresAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Organization? org,
    User? user,
  }) {
    return ApiKey(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      orgId: orgId ?? this.orgId,
      name: name ?? this.name,
      keyHash: keyHash ?? this.keyHash,
      scopes: scopes ?? this.scopes,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      org: org ?? this.org,
      user: user ?? this.user,
    );
  }
}
