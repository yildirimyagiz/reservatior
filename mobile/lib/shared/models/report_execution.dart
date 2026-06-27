import 'organization.dart';
import 'report.dart';

class ReportExecution {
  final String id;
  final String orgId;
  final String reportId;
  final DateTime executedAt;
  final String executedBy;
  final String status;
  final String? resultUrl;
  final String? errorMessage;
  final DateTime createdAt;
  final Organization org;
  final Report report;

  const ReportExecution({
    required this.id,
    required this.orgId,
    required this.reportId,
    required this.executedAt,
    required this.executedBy,
    required this.status,
    this.resultUrl,
    this.errorMessage,
    required this.createdAt,
    required this.org,
    required this.report,
  });

  factory ReportExecution.fromJson(Map<String, dynamic> json) {
    return ReportExecution(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      reportId: json['reportId'] as String,
      executedAt: DateTime.parse(json['executedAt'] as String),
      executedBy: json['executedBy'] as String,
      status: json['status'] as String,
      resultUrl: json['resultUrl'] as String?,
      errorMessage: json['errorMessage'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      report: Report.fromJson(json['report'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'reportId': reportId,
      'executedAt': executedAt.toIso8601String(),
      'executedBy': executedBy,
      'status': status,
      'resultUrl': resultUrl,
      'errorMessage': errorMessage,
      'createdAt': createdAt.toIso8601String(),
      'org': org.toJson(),
      'report': report.toJson(),
    };
  }

  ReportExecution copyWith({
    String? id,
    String? orgId,
    String? reportId,
    DateTime? executedAt,
    String? executedBy,
    String? status,
    String? resultUrl,
    String? errorMessage,
    DateTime? createdAt,
    Organization? org,
    Report? report,
  }) {
    return ReportExecution(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      reportId: reportId ?? this.reportId,
      executedAt: executedAt ?? this.executedAt,
      executedBy: executedBy ?? this.executedBy,
      status: status ?? this.status,
      resultUrl: resultUrl ?? this.resultUrl,
      errorMessage: errorMessage ?? this.errorMessage,
      createdAt: createdAt ?? this.createdAt,
      org: org ?? this.org,
      report: report ?? this.report,
    );
  }
}
