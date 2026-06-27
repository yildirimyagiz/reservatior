import 'organization.dart';

class PerformanceAlert {
  final String id;
  final String? orgId;
  final String alertType;
  final String severity;
  final String metricName;
  final double threshold;
  final double actualValue;
  final String description;
  final String status;
  final DateTime? acknowledgedAt;
  final String? acknowledgedBy;
  final DateTime? resolvedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Organization? org;

  const PerformanceAlert({
    required this.id,
    this.orgId,
    required this.alertType,
    required this.severity,
    required this.metricName,
    required this.threshold,
    required this.actualValue,
    required this.description,
    required this.status,
    this.acknowledgedAt,
    this.acknowledgedBy,
    this.resolvedAt,
    required this.createdAt,
    required this.updatedAt,
    this.org,
  });

  factory PerformanceAlert.fromJson(Map<String, dynamic> json) {
    return PerformanceAlert(
      id: json['id'] as String,
      orgId: json['orgId'] as String?,
      alertType: json['alertType'] as String,
      severity: json['severity'] as String,
      metricName: json['metricName'] as String,
      threshold: (json['threshold'] as num).toDouble(),
      actualValue: (json['actualValue'] as num).toDouble(),
      description: json['description'] as String,
      status: json['status'] as String,
      acknowledgedAt: json['acknowledgedAt'] != null ? DateTime.parse(json['acknowledgedAt'] as String) : null,
      acknowledgedBy: json['acknowledgedBy'] as String?,
      resolvedAt: json['resolvedAt'] != null ? DateTime.parse(json['resolvedAt'] as String) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'alertType': alertType,
      'severity': severity,
      'metricName': metricName,
      'threshold': threshold,
      'actualValue': actualValue,
      'description': description,
      'status': status,
      'acknowledgedAt': acknowledgedAt?.toIso8601String(),
      'acknowledgedBy': acknowledgedBy,
      'resolvedAt': resolvedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'org': org?.toJson(),
    };
  }

  PerformanceAlert copyWith({
    String? id,
    String? orgId,
    String? alertType,
    String? severity,
    String? metricName,
    double? threshold,
    double? actualValue,
    String? description,
    String? status,
    DateTime? acknowledgedAt,
    String? acknowledgedBy,
    DateTime? resolvedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    Organization? org,
  }) {
    return PerformanceAlert(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      alertType: alertType ?? this.alertType,
      severity: severity ?? this.severity,
      metricName: metricName ?? this.metricName,
      threshold: threshold ?? this.threshold,
      actualValue: actualValue ?? this.actualValue,
      description: description ?? this.description,
      status: status ?? this.status,
      acknowledgedAt: acknowledgedAt ?? this.acknowledgedAt,
      acknowledgedBy: acknowledgedBy ?? this.acknowledgedBy,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      org: org ?? this.org,
    );
  }
}
