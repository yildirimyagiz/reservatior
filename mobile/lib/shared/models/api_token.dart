import 'user.dart';

class ApiToken {
  final String id;
  final String userId;
  final String name;
  final String tokenHash;
  final List<String> scopes;
  final DateTime? lastUsedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final User user;

  const ApiToken({
    required this.id,
    required this.userId,
    required this.name,
    required this.tokenHash,
    this.scopes = const [],
    this.lastUsedAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.user,
  });

  factory ApiToken.fromJson(Map<String, dynamic> json) {
    return ApiToken(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      tokenHash: json['tokenHash'] as String,
      scopes: (json['scopes'] as List<dynamic>?)?.cast<String>() ?? [],
      lastUsedAt: json['lastUsedAt'] != null ? DateTime.parse(json['lastUsedAt'] as String) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'tokenHash': tokenHash,
      'scopes': scopes,
      'lastUsedAt': lastUsedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'user': user.toJson(),
    };
  }

  ApiToken copyWith({
    String? id,
    String? userId,
    String? name,
    String? tokenHash,
    List<String>? scopes,
    DateTime? lastUsedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    User? user,
  }) {
    return ApiToken(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      tokenHash: tokenHash ?? this.tokenHash,
      scopes: scopes ?? this.scopes,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      user: user ?? this.user,
    );
  }
}
