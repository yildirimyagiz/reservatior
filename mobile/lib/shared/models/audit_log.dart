import 'organization.dart';
import 'user.dart';

class AuditLog {
  final String id;
  final String orgId;
  final String? userId;
  final String action;
  final String entityType;
  final String entityId;
  final String? ipAddres;
  final String? userAgent;
  final String? sessionId;
  final DateTime createdAt;
  final Organization org;
  final User? user;

  const AuditLog({
    required this.id,
    required this.orgId,
    this.userId,
    required this.action,
    required this.entityType,
    required this.entityId,
    this.ipAddres,
    this.userAgent,
    this.sessionId,
    required this.createdAt,
    required this.org,
    this.user,
  });

  factory AuditLog.fromJson(Map<String, dynamic> json) {
    return AuditLog(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      userId: json['userId'] as String?,
      action: json['action'] as String,
      entityType: json['entityType'] as String,
      entityId: json['entityId'] as String,
      ipAddres: json['IpAddres'] as String?,
      userAgent: json['userAgent'] as String?,
      sessionId: json['sessionId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      user: json['user'] != null ? User.fromJson(json['user'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'userId': userId,
      'action': action,
      'entityType': entityType,
      'entityId': entityId,
      'IpAddres': ipAddres,
      'userAgent': userAgent,
      'sessionId': sessionId,
      'createdAt': createdAt.toIso8601String(),
      'org': org.toJson(),
      'user': user?.toJson(),
    };
  }

  AuditLog copyWith({
    String? id,
    String? orgId,
    String? userId,
    String? action,
    String? entityType,
    String? entityId,
    String? ipAddres,
    String? userAgent,
    String? sessionId,
    DateTime? createdAt,
    Organization? org,
    User? user,
  }) {
    return AuditLog(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      userId: userId ?? this.userId,
      action: action ?? this.action,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      ipAddres: ipAddres ?? this.ipAddres,
      userAgent: userAgent ?? this.userAgent,
      sessionId: sessionId ?? this.sessionId,
      createdAt: createdAt ?? this.createdAt,
      org: org ?? this.org,
      user: user ?? this.user,
    );
  }
}
