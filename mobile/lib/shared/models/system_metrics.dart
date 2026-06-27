import 'organization.dart';

class SystemMetrics {
  final String id;
  final String? orgId;
  final String metricType;
  final String metricName;
  final double value;
  final String unit;
  final DateTime timestamp;
  final DateTime collectedAt;
  final Organization? org;

  const SystemMetrics({
    required this.id,
    this.orgId,
    required this.metricType,
    required this.metricName,
    required this.value,
    required this.unit,
    required this.timestamp,
    required this.collectedAt,
    this.org,
  });

  factory SystemMetrics.fromJson(Map<String, dynamic> json) {
    return SystemMetrics(
      id: json['id'] as String,
      orgId: json['orgId'] as String?,
      metricType: json['metricType'] as String,
      metricName: json['metricName'] as String,
      value: (json['value'] as num).toDouble(),
      unit: json['unit'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      collectedAt: DateTime.parse(json['collectedAt'] as String),
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'metricType': metricType,
      'metricName': metricName,
      'value': value,
      'unit': unit,
      'timestamp': timestamp.toIso8601String(),
      'collectedAt': collectedAt.toIso8601String(),
      'org': org?.toJson(),
    };
  }

  SystemMetrics copyWith({
    String? id,
    String? orgId,
    String? metricType,
    String? metricName,
    double? value,
    String? unit,
    DateTime? timestamp,
    DateTime? collectedAt,
    Organization? org,
  }) {
    return SystemMetrics(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      metricType: metricType ?? this.metricType,
      metricName: metricName ?? this.metricName,
      value: value ?? this.value,
      unit: unit ?? this.unit,
      timestamp: timestamp ?? this.timestamp,
      collectedAt: collectedAt ?? this.collectedAt,
      org: org ?? this.org,
    );
  }
}
