import 'package:reservatior/shared/enums/sync_status.dart';
import 'mls_connection.dart';
import 'organization.dart';

class MlsSyncJob {
  final String id;
  final String orgId;
  final String connectionId;
  final SyncStatus status;
  final DateTime? startedAt;
  final DateTime? finishedAt;
  final String? error;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final MlsConnection connection;
  final Organization org;

  const MlsSyncJob({
    required this.id,
    required this.orgId,
    required this.connectionId,
    required this.status,
    this.startedAt,
    this.finishedAt,
    this.error,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.connection,
    required this.org,
  });

  factory MlsSyncJob.fromJson(Map<String, dynamic> json) {
    return MlsSyncJob(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      connectionId: json['connectionId'] as String,
      status: SyncStatus.values.firstWhere((v) => v.name == json['status']),
      startedAt: json['startedAt'] != null ? DateTime.parse(json['startedAt'] as String) : null,
      finishedAt: json['finishedAt'] != null ? DateTime.parse(json['finishedAt'] as String) : null,
      error: json['error'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      connection: MlsConnection.fromJson(json['connection'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'connectionId': connectionId,
      'status': status.name,
      'startedAt': startedAt?.toIso8601String(),
      'finishedAt': finishedAt?.toIso8601String(),
      'error': error,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'connection': connection.toJson(),
      'org': org.toJson(),
    };
  }

  MlsSyncJob copyWith({
    String? id,
    String? orgId,
    String? connectionId,
    SyncStatus? status,
    DateTime? startedAt,
    DateTime? finishedAt,
    String? error,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    MlsConnection? connection,
    Organization? org,
  }) {
    return MlsSyncJob(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      connectionId: connectionId ?? this.connectionId,
      status: status ?? this.status,
      startedAt: startedAt ?? this.startedAt,
      finishedAt: finishedAt ?? this.finishedAt,
      error: error ?? this.error,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      connection: connection ?? this.connection,
      org: org ?? this.org,
    );
  }
}
