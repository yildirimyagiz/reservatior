import 'mobile_device.dart';
import 'organization.dart';
import 'user.dart';

class OfflineSyncQueue {
  final String id;
  final String orgId;
  final String userId;
  final String deviceId;
  final String entityType;
  final String entityId;
  final String operation;
  final int version;
  final String syncStatus;
  final DateTime createdAt;
  final DateTime? syncedAt;
  final MobileDevice device;
  final Organization org;
  final User user;

  const OfflineSyncQueue({
    required this.id,
    required this.orgId,
    required this.userId,
    required this.deviceId,
    required this.entityType,
    required this.entityId,
    required this.operation,
    required this.version,
    required this.syncStatus,
    required this.createdAt,
    this.syncedAt,
    required this.device,
    required this.org,
    required this.user,
  });

  factory OfflineSyncQueue.fromJson(Map<String, dynamic> json) {
    return OfflineSyncQueue(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      userId: json['userId'] as String,
      deviceId: json['deviceId'] as String,
      entityType: json['entityType'] as String,
      entityId: json['entityId'] as String,
      operation: json['operation'] as String,
      version: json['version'] as int,
      syncStatus: json['syncStatus'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      syncedAt: json['syncedAt'] != null ? DateTime.parse(json['syncedAt'] as String) : null,
      device: MobileDevice.fromJson(json['device'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'userId': userId,
      'deviceId': deviceId,
      'entityType': entityType,
      'entityId': entityId,
      'operation': operation,
      'version': version,
      'syncStatus': syncStatus,
      'createdAt': createdAt.toIso8601String(),
      'syncedAt': syncedAt?.toIso8601String(),
      'device': device.toJson(),
      'org': org.toJson(),
      'user': user.toJson(),
    };
  }

  OfflineSyncQueue copyWith({
    String? id,
    String? orgId,
    String? userId,
    String? deviceId,
    String? entityType,
    String? entityId,
    String? operation,
    int? version,
    String? syncStatus,
    DateTime? createdAt,
    DateTime? syncedAt,
    MobileDevice? device,
    Organization? org,
    User? user,
  }) {
    return OfflineSyncQueue(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      userId: userId ?? this.userId,
      deviceId: deviceId ?? this.deviceId,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      operation: operation ?? this.operation,
      version: version ?? this.version,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt ?? this.createdAt,
      syncedAt: syncedAt ?? this.syncedAt,
      device: device ?? this.device,
      org: org ?? this.org,
      user: user ?? this.user,
    );
  }
}
