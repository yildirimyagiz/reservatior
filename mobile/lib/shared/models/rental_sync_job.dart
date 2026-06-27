import 'package:reservatior/shared/enums/rental_platform.dart';
import 'package:reservatior/shared/enums/sync_direction.dart';
import 'package:reservatior/shared/enums/sync_status.dart';
import 'api_integration.dart';
import 'organization.dart';

class RentalSyncJob {
  final String id;
  final String orgId;
  final String integrationId;
  final RentalPlatform platform;
  final SyncStatus status;
  final String jobType;
  final SyncDirection direction;
  final DateTime? startedAt;
  final DateTime? finishedAt;
  final String? error;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final APIIntegration integration;
  final Organization org;

  const RentalSyncJob({
    required this.id,
    required this.orgId,
    required this.integrationId,
    required this.platform,
    required this.status,
    required this.jobType,
    required this.direction,
    this.startedAt,
    this.finishedAt,
    this.error,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.integration,
    required this.org,
  });

  factory RentalSyncJob.fromJson(Map<String, dynamic> json) {
    return RentalSyncJob(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      integrationId: json['integrationId'] as String,
      platform: RentalPlatform.values.firstWhere((v) => v.name == json['platform']),
      status: SyncStatus.values.firstWhere((v) => v.name == json['status']),
      jobType: json['jobType'] as String,
      direction: SyncDirection.values.firstWhere((v) => v.name == json['direction']),
      startedAt: json['startedAt'] != null ? DateTime.parse(json['startedAt'] as String) : null,
      finishedAt: json['finishedAt'] != null ? DateTime.parse(json['finishedAt'] as String) : null,
      error: json['error'] as String?,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      integration: APIIntegration.fromJson(json['integration'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'integrationId': integrationId,
      'platform': platform.name,
      'status': status.name,
      'jobType': jobType,
      'direction': direction.name,
      'startedAt': startedAt?.toIso8601String(),
      'finishedAt': finishedAt?.toIso8601String(),
      'error': error,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'integration': integration.toJson(),
      'org': org.toJson(),
    };
  }

  RentalSyncJob copyWith({
    String? id,
    String? orgId,
    String? integrationId,
    RentalPlatform? platform,
    SyncStatus? status,
    String? jobType,
    SyncDirection? direction,
    DateTime? startedAt,
    DateTime? finishedAt,
    String? error,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    APIIntegration? integration,
    Organization? org,
  }) {
    return RentalSyncJob(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      integrationId: integrationId ?? this.integrationId,
      platform: platform ?? this.platform,
      status: status ?? this.status,
      jobType: jobType ?? this.jobType,
      direction: direction ?? this.direction,
      startedAt: startedAt ?? this.startedAt,
      finishedAt: finishedAt ?? this.finishedAt,
      error: error ?? this.error,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      integration: integration ?? this.integration,
      org: org ?? this.org,
    );
  }
}
