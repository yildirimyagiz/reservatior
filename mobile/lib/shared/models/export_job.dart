import 'package:reservatior/shared/enums/export_status.dart';
import 'package:reservatior/shared/enums/export_type.dart';
import 'export_file.dart';
import 'organization.dart';

class ExportJob {
  final String id;
  final String orgId;
  final ExportType type;
  final ExportStatus status;
  final DateTime? startedAt;
  final DateTime? finishedAt;
  final String? error;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<ExportFile> files;
  final Organization org;

  const ExportJob({
    required this.id,
    required this.orgId,
    required this.type,
    required this.status,
    this.startedAt,
    this.finishedAt,
    this.error,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.files = const [],
    required this.org,
  });

  factory ExportJob.fromJson(Map<String, dynamic> json) {
    return ExportJob(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      type: ExportType.values.firstWhere((v) => v.name == json['type']),
      status: ExportStatus.values.firstWhere((v) => v.name == json['status']),
      startedAt: json['startedAt'] != null ? DateTime.parse(json['startedAt'] as String) : null,
      finishedAt: json['finishedAt'] != null ? DateTime.parse(json['finishedAt'] as String) : null,
      error: json['error'] as String?,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      files: (json['files'] as List<dynamic>?)?.map((e) => ExportFile.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'type': type.name,
      'status': status.name,
      'startedAt': startedAt?.toIso8601String(),
      'finishedAt': finishedAt?.toIso8601String(),
      'error': error,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'files': files.map((e) => e.toJson()).toList(),
      'org': org.toJson(),
    };
  }

  ExportJob copyWith({
    String? id,
    String? orgId,
    ExportType? type,
    ExportStatus? status,
    DateTime? startedAt,
    DateTime? finishedAt,
    String? error,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    List<ExportFile>? files,
    Organization? org,
  }) {
    return ExportJob(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      type: type ?? this.type,
      status: status ?? this.status,
      startedAt: startedAt ?? this.startedAt,
      finishedAt: finishedAt ?? this.finishedAt,
      error: error ?? this.error,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      files: files ?? this.files,
      org: org ?? this.org,
    );
  }
}
