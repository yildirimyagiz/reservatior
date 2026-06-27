import 'organization.dart';
import 'user.dart';

class UserActivityLog {
  final String id;
  final String userId;
  final String? orgId;
  final String action;
  final String? entityType;
  final String? entityId;
  final String? ipAddres;
  final String? userAgent;
  final DateTime createdAt;
  final Organization? org;
  final User user;

  const UserActivityLog({
    required this.id,
    required this.userId,
    this.orgId,
    required this.action,
    this.entityType,
    this.entityId,
    this.ipAddres,
    this.userAgent,
    required this.createdAt,
    this.org,
    required this.user,
  });

  factory UserActivityLog.fromJson(Map<String, dynamic> json) {
    return UserActivityLog(
      id: json['id'] as String,
      userId: json['userId'] as String,
      orgId: json['orgId'] as String?,
      action: json['action'] as String,
      entityType: json['entityType'] as String?,
      entityId: json['entityId'] as String?,
      ipAddres: json['IpAddres'] as String?,
      userAgent: json['userAgent'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'orgId': orgId,
      'action': action,
      'entityType': entityType,
      'entityId': entityId,
      'IpAddres': ipAddres,
      'userAgent': userAgent,
      'createdAt': createdAt.toIso8601String(),
      'org': org?.toJson(),
      'user': user.toJson(),
    };
  }

  UserActivityLog copyWith({
    String? id,
    String? userId,
    String? orgId,
    String? action,
    String? entityType,
    String? entityId,
    String? ipAddres,
    String? userAgent,
    DateTime? createdAt,
    Organization? org,
    User? user,
  }) {
    return UserActivityLog(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      orgId: orgId ?? this.orgId,
      action: action ?? this.action,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      ipAddres: ipAddres ?? this.ipAddres,
      userAgent: userAgent ?? this.userAgent,
      createdAt: createdAt ?? this.createdAt,
      org: org ?? this.org,
      user: user ?? this.user,
    );
  }
}
