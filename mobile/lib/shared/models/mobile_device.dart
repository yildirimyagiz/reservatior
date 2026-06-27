import 'offline_sync_queue.dart';
import 'organization.dart';
import 'user.dart';

class MobileDevice {
  final String id;
  final String orgId;
  final String userId;
  final String deviceId;
  final String deviceType;
  final String? deviceToken;
  final String appVersion;
  final String osVersion;
  final bool isActive;
  final DateTime? lastLoginAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Organization org;
  final User user;
  final List<OfflineSyncQueue> offlineSyncQueues;

  const MobileDevice({
    required this.id,
    required this.orgId,
    required this.userId,
    required this.deviceId,
    required this.deviceType,
    this.deviceToken,
    required this.appVersion,
    required this.osVersion,
    required this.isActive,
    this.lastLoginAt,
    required this.createdAt,
    required this.updatedAt,
    required this.org,
    required this.user,
    this.offlineSyncQueues = const [],
  });

  factory MobileDevice.fromJson(Map<String, dynamic> json) {
    return MobileDevice(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      userId: json['userId'] as String,
      deviceId: json['deviceId'] as String,
      deviceType: json['deviceType'] as String,
      deviceToken: json['deviceToken'] as String?,
      appVersion: json['appVersion'] as String,
      osVersion: json['osVersion'] as String,
      isActive: json['isActive'] as bool,
      lastLoginAt: json['lastLoginAt'] != null ? DateTime.parse(json['lastLoginAt'] as String) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      offlineSyncQueues: (json['offlineSyncQueues'] as List<dynamic>?)?.map((e) => OfflineSyncQueue.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'userId': userId,
      'deviceId': deviceId,
      'deviceType': deviceType,
      'deviceToken': deviceToken,
      'appVersion': appVersion,
      'osVersion': osVersion,
      'isActive': isActive,
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'org': org.toJson(),
      'user': user.toJson(),
      'offlineSyncQueues': offlineSyncQueues.map((e) => e.toJson()).toList(),
    };
  }

  MobileDevice copyWith({
    String? id,
    String? orgId,
    String? userId,
    String? deviceId,
    String? deviceType,
    String? deviceToken,
    String? appVersion,
    String? osVersion,
    bool? isActive,
    DateTime? lastLoginAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    Organization? org,
    User? user,
    List<OfflineSyncQueue>? offlineSyncQueues,
  }) {
    return MobileDevice(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      userId: userId ?? this.userId,
      deviceId: deviceId ?? this.deviceId,
      deviceType: deviceType ?? this.deviceType,
      deviceToken: deviceToken ?? this.deviceToken,
      appVersion: appVersion ?? this.appVersion,
      osVersion: osVersion ?? this.osVersion,
      isActive: isActive ?? this.isActive,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      org: org ?? this.org,
      user: user ?? this.user,
      offlineSyncQueues: offlineSyncQueues ?? this.offlineSyncQueues,
    );
  }
}
