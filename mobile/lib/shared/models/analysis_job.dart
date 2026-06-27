import 'document.dart';
import 'document_analysis.dart';
import 'organization.dart';

class AnalysisJob {
  final String id;
  final String documentId;
  final String orgId;
  final String status;
  final String type;
  final String priority;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final int? processingTime;
  final String? errorMessage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Document document;
  final Organization org;
  final List<DocumentAnalysis> analyses;

  const AnalysisJob({
    required this.id,
    required this.documentId,
    required this.orgId,
    required this.status,
    required this.type,
    required this.priority,
    this.startedAt,
    this.completedAt,
    this.processingTime,
    this.errorMessage,
    required this.createdAt,
    required this.updatedAt,
    required this.document,
    required this.org,
    this.analyses = const [],
  });

  factory AnalysisJob.fromJson(Map<String, dynamic> json) {
    return AnalysisJob(
      id: json['id'] as String,
      documentId: json['documentId'] as String,
      orgId: json['orgId'] as String,
      status: json['status'] as String,
      type: json['type'] as String,
      priority: json['priority'] as String,
      startedAt: json['startedAt'] != null ? DateTime.parse(json['startedAt'] as String) : null,
      completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt'] as String) : null,
      processingTime: json['processingTime'] as int?,
      errorMessage: json['errorMessage'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      document: Document.fromJson(json['document'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      analyses: (json['analyses'] as List<dynamic>?)?.map((e) => DocumentAnalysis.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'documentId': documentId,
      'orgId': orgId,
      'status': status,
      'type': type,
      'priority': priority,
      'startedAt': startedAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'processingTime': processingTime,
      'errorMessage': errorMessage,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'document': document.toJson(),
      'org': org.toJson(),
      'analyses': analyses.map((e) => e.toJson()).toList(),
    };
  }

  AnalysisJob copyWith({
    String? id,
    String? documentId,
    String? orgId,
    String? status,
    String? type,
    String? priority,
    DateTime? startedAt,
    DateTime? completedAt,
    int? processingTime,
    String? errorMessage,
    DateTime? createdAt,
    DateTime? updatedAt,
    Document? document,
    Organization? org,
    List<DocumentAnalysis>? analyses,
  }) {
    return AnalysisJob(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      orgId: orgId ?? this.orgId,
      status: status ?? this.status,
      type: type ?? this.type,
      priority: priority ?? this.priority,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      processingTime: processingTime ?? this.processingTime,
      errorMessage: errorMessage ?? this.errorMessage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      document: document ?? this.document,
      org: org ?? this.org,
      analyses: analyses ?? this.analyses,
    );
  }
}
