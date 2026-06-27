import 'package:reservatior/shared/enums/export_status.dart';

class Job {
  final String id;
  final String? orgId;
  final String type;
  final ExportStatus status;
  final DateTime runAt;
  final int attempts;
  final String? lastError;
  final DateTime? lockedAt;
  final String? lockedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const Job({
    required this.id,
    this.orgId,
    required this.type,
    required this.status,
    required this.runAt,
    required this.attempts,
    this.lastError,
    this.lockedAt,
    this.lockedBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'] as String,
      orgId: json['orgId'] as String?,
      type: json['type'] as String,
      status: ExportStatus.values.firstWhere((v) => v.name == json['status']),
      runAt: DateTime.parse(json['runAt'] as String),
      attempts: json['attempts'] as int,
      lastError: json['lastError'] as String?,
      lockedAt: json['lockedAt'] != null ? DateTime.parse(json['lockedAt'] as String) : null,
      lockedBy: json['lockedBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'type': type,
      'status': status.name,
      'runAt': runAt.toIso8601String(),
      'attempts': attempts,
      'lastError': lastError,
      'lockedAt': lockedAt?.toIso8601String(),
      'lockedBy': lockedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
    };
  }

  Job copyWith({
    String? id,
    String? orgId,
    String? type,
    ExportStatus? status,
    DateTime? runAt,
    int? attempts,
    String? lastError,
    DateTime? lockedAt,
    String? lockedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return Job(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      type: type ?? this.type,
      status: status ?? this.status,
      runAt: runAt ?? this.runAt,
      attempts: attempts ?? this.attempts,
      lastError: lastError ?? this.lastError,
      lockedAt: lockedAt ?? this.lockedAt,
      lockedBy: lockedBy ?? this.lockedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}
