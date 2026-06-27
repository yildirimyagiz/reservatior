import 'user.dart';

class Session {
  final String id;
  final String userId;
  final String tokenHash;
  final DateTime expiresAt;
  final String? ip;
  final String? userAgent;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final User user;

  const Session({
    required this.id,
    required this.userId,
    required this.tokenHash,
    required this.expiresAt,
    this.ip,
    this.userAgent,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.user,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'] as String,
      userId: json['userId'] as String,
      tokenHash: json['tokenHash'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      ip: json['ip'] as String?,
      userAgent: json['userAgent'] as String?,
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
      'tokenHash': tokenHash,
      'expiresAt': expiresAt.toIso8601String(),
      'ip': ip,
      'userAgent': userAgent,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'user': user.toJson(),
    };
  }

  Session copyWith({
    String? id,
    String? userId,
    String? tokenHash,
    DateTime? expiresAt,
    String? ip,
    String? userAgent,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    User? user,
  }) {
    return Session(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      tokenHash: tokenHash ?? this.tokenHash,
      expiresAt: expiresAt ?? this.expiresAt,
      ip: ip ?? this.ip,
      userAgent: userAgent ?? this.userAgent,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      user: user ?? this.user,
    );
  }
}
