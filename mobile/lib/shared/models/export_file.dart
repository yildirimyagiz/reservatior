import 'export_job.dart';
import 'organization.dart';

class ExportFile {
  final String id;
  final String orgId;
  final String exportJobId;
  final String fileName;
  final String storageKey;
  final String mimeType;
  final int sizeBytes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final ExportJob exportJob;
  final Organization org;

  const ExportFile({
    required this.id,
    required this.orgId,
    required this.exportJobId,
    required this.fileName,
    required this.storageKey,
    required this.mimeType,
    required this.sizeBytes,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.exportJob,
    required this.org,
  });

  factory ExportFile.fromJson(Map<String, dynamic> json) {
    return ExportFile(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      exportJobId: json['exportJobId'] as String,
      fileName: json['fileName'] as String,
      storageKey: json['storageKey'] as String,
      mimeType: json['mimeType'] as String,
      sizeBytes: json['sizeBytes'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      exportJob: ExportJob.fromJson(json['exportJob'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'exportJobId': exportJobId,
      'fileName': fileName,
      'storageKey': storageKey,
      'mimeType': mimeType,
      'sizeBytes': sizeBytes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'exportJob': exportJob.toJson(),
      'org': org.toJson(),
    };
  }

  ExportFile copyWith({
    String? id,
    String? orgId,
    String? exportJobId,
    String? fileName,
    String? storageKey,
    String? mimeType,
    int? sizeBytes,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    ExportJob? exportJob,
    Organization? org,
  }) {
    return ExportFile(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      exportJobId: exportJobId ?? this.exportJobId,
      fileName: fileName ?? this.fileName,
      storageKey: storageKey ?? this.storageKey,
      mimeType: mimeType ?? this.mimeType,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      exportJob: exportJob ?? this.exportJob,
      org: org ?? this.org,
    );
  }
}
