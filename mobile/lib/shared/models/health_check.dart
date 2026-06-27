import 'organization.dart';

class HealthCheck {
  final String id;
  final String? orgId;
  final String serviceName;
  final String componentName;
  final String status;
  final int? responseTime;
  final String? errorMessage;
  final DateTime checkedAt;
  final Organization? org;

  const HealthCheck({
    required this.id,
    this.orgId,
    required this.serviceName,
    required this.componentName,
    required this.status,
    this.responseTime,
    this.errorMessage,
    required this.checkedAt,
    this.org,
  });

  factory HealthCheck.fromJson(Map<String, dynamic> json) {
    return HealthCheck(
      id: json['id'] as String,
      orgId: json['orgId'] as String?,
      serviceName: json['serviceName'] as String,
      componentName: json['componentName'] as String,
      status: json['status'] as String,
      responseTime: json['responseTime'] as int?,
      errorMessage: json['errorMessage'] as String?,
      checkedAt: DateTime.parse(json['checkedAt'] as String),
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'serviceName': serviceName,
      'componentName': componentName,
      'status': status,
      'responseTime': responseTime,
      'errorMessage': errorMessage,
      'checkedAt': checkedAt.toIso8601String(),
      'org': org?.toJson(),
    };
  }

  HealthCheck copyWith({
    String? id,
    String? orgId,
    String? serviceName,
    String? componentName,
    String? status,
    int? responseTime,
    String? errorMessage,
    DateTime? checkedAt,
    Organization? org,
  }) {
    return HealthCheck(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      serviceName: serviceName ?? this.serviceName,
      componentName: componentName ?? this.componentName,
      status: status ?? this.status,
      responseTime: responseTime ?? this.responseTime,
      errorMessage: errorMessage ?? this.errorMessage,
      checkedAt: checkedAt ?? this.checkedAt,
      org: org ?? this.org,
    );
  }
}
